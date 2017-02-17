//
//  TabViewController.swift
//  On-the-Map
//
//  Created by Christine Chang on 2/9/17.
//  Copyright © 2017 Christine Chang. All rights reserved.
//

import UIKit

class TabViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        loadStudentLocations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadStudentLocations() {
        // load student pins
        ParseClient.sharedInstance().getStudentLocations() { (studentLocations, error) in
            
            guard error == nil else {
                print("error")
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
    }

}
