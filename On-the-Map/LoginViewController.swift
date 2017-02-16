//
//  LoginViewController.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/18/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var debugTextLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginPressed(_ sender: AnyObject) {
        
        let username = self.email.text!
        let password = self.password.text!
        
        UdacityClient.sharedInstance().postSession(username: username, password: password) { (sessionID, error) in
            
            guard error == nil else {
                self.displayError("Your email or password is incorrect.")
                return
            }
            
            // check (unwrap) that we have sessionID
            if let sessionID = sessionID {
                
                // load 100 students
                ParseClient.sharedInstance().getStudentLocations() { (studentLocations, error) in
                    
                    guard error == nil else {
                        self.displayError("Could not load student pins.")
                        return
                    }
                    
                    // empty array to be populated with StudentInfo structs (stored in StudentInfo.swift)
                    var studentInfoArray = StudentInfo.studentInfoArray
                    
                    // for loop iterating through each dictionary in the array of studentLocation dictionaries. For each dictionary, create a StudentInfo instance containing the dictionary info.
                    for dictionary in studentLocations! {
                        let studentStruct = StudentInfo(dictionary: dictionary)
                        studentInfoArray.append(studentStruct)
                    }
                }
                
                // go to the next screen
                var controller = self.storyboard?.instantiateViewController(withIdentifier: "NavigationController")
                
                self.present(controller!, animated: true, completion: nil)
            }
        }
    }

    // MARK: Login
    
    private func successfulLogin() {
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        present(controller, animated: true, completion: nil)
    }

}

// MARK: - LoginViewController (Configure UI)

private extension LoginViewController {
    
    func setUIEnabled(_ enabled: Bool) {
        loginButton.isEnabled = enabled
        debugTextLabel.isEnabled = enabled
        
        // adjust login button alpha
        if enabled {
            loginButton.alpha = 1.0
        } else {
            loginButton.alpha = 0.5
        }
    }
    
    func displayError(_ errorString: String?) {
        if let errorString = errorString {
            debugTextLabel.text = errorString
        }
    }
}

