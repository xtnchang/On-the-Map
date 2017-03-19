//
//  TabViewController.swift
//  On-the-Map
//
//  Created by Christine Chang on 2/9/17.
//  Copyright © 2017 Christine Chang. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    var firstName: String?
    var lastName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadStudentLocations()
        getUserData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // Load student locations in both the map view and table view.
    func loadStudentLocations() {
        
        // studentLocations is an array of dictionaries
        ParseClient.sharedInstance().getStudentLocations() { (success, studentInfoArray, error) in
            
            performUIUpdatesOnMain {
                
                if success {
                    if let mapVC = self.viewControllers?[0] as? MapViewController {
                        mapVC.studentInfoArrayToLoad = studentInfoArray!
                        mapVC.loadStudents(studentInfo: studentInfoArray!)
                    }
                    if let listVC = self.viewControllers?[1] as? ListViewController {
                        listVC.studentInfoArrayToLoad = studentInfoArray!
                    }
                } else {
                    self.showErrorAlert(messageText: "Pins failed to download.")
                }
            }
        }
    }
    
    // Get the user first name and last name
    func getUserData() {
        UdacityClient.sharedInstance().getUserData() { (success, firstName, lastName, error) in
            
            guard error == nil else {
                self.showErrorAlert(messageText: "Couldn't find your first and last name.")
                return
            }
            
            self.firstName = firstName
            self.lastName = lastName
        }
    }
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        UdacityClient.sharedInstance().deleteSession() { (success, sessionID, error) in
            
            performUIUpdatesOnMain {
                
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showErrorAlert(messageText: "Logout failed.")
                }
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addPinPressed(_ sender: Any) {
        
        ParseClient.sharedInstance().getSingleStudentLocation() { (studentLocation, error) in
         
            performUIUpdatesOnMain {
                
                if studentLocation != nil {
                    self.showErrorAlert(messageText: "Do you want to overwrite your existing location?")
                    self.openAddPinVC()
                } else {
                    self.openAddPinVC()
                }
            }
        }
    }
    
    // Transition to the next view controller
    func openAddPinVC() {
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "AddPinViewController") as! AddPinViewController
        controller.firstName = self.firstName
        controller.lastName = self.lastName
        present(controller, animated: true, completion: nil)
    }
}

private extension TabViewController {
    
    func showErrorAlert(messageText: String) {
        let alert = UIAlertController(title: "Alert", message: messageText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
