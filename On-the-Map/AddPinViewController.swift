//
//  AddPinViewController.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/18/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class AddPinViewController: UIViewController {
    
    var firstName: String?
    var lastName: String?
    
    var geocoder = CLGeocoder()
    
    @IBOutlet weak var locationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func findLocationPressed(_ sender: Any) {
        
        // checkMapString(mapString: self.locationTextField.text!)
        
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "AddLinkViewController") as! AddLinkViewController
        
        // Pass first name and last name data to the next controller
        controller.firstName = self.firstName
        controller.lastName = self.lastName
        
        // Pass the entered city data to the next controller
        controller.mapString = self.locationTextField.text
        present(controller, animated: true, completion: nil)
    }
    
//    func checkMapString(mapString: String) {
//        geocoder.geocodeAddressString(mapString) { (placemarks, error) in
//            
//            // Show alert if mapString is not a valid location
//            if error != nil {
//                self.showErrorAlert(message: "Please enter a valid location.")
//            } else {
//                let controller = self.storyboard!.instantiateViewController(withIdentifier: "AddLinkViewController") as! AddLinkViewController
//                
//                // Pass first name and last name data to the next controller
//                controller.firstName = self.firstName
//                controller.lastName = self.lastName
//                
//                // Pass the entered city data to the next controller
//                controller.mapString = self.locationTextField.text
//                present(controller, animated: true, completion: nil)
//            }
//        }
//    }
}

private extension AddPinViewController {
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
