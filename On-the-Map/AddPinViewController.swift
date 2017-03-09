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
    
    //MARK:- TODO in func viewWillAppear
    // get my Parse objectID - if it exists
    //  - implement using Parse's GET a Student Location using your studentID in the url query component ("?where={"uniqueKey":"\(UdacityClient.sharedInstance.userID)"})
    // if the method returns a valid JSON, , extract the objectID, store in StudentInfo.userInfo
    
    
    
    @IBAction func findLocationPressed(_ sender: Any) {
        
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "AddLinkViewController") as? AddLinkViewController {
            
            // Pass the entered city to the next controller
            controller.enteredLocation = self.locationTextField.text
            present(controller, animated: true, completion: nil)
        } else {
           print("view controller not found")
        }
    }
}
