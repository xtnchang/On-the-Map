//
//  ListViewController.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/20/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    
    var studentInfoArrayToLoad = StudentInfo.arrayOfStudentStructs
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentInfoArrayToLoad.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentNameCell")!
        
        let student = self.studentInfoArrayToLoad[indexPath.row]
        
        // Since each student is a struct, not an array, use dot syntax rather than bracket subscript syntax.
        cell.textLabel?.text = student.firstName
        
        return cell
    }
    
    // MARK: UITableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let student = self.studentInfoArrayToLoad[indexPath.row]
        
        if let studentURL = URL(string: student.mediaURL!) {
            UIApplication.shared.open(studentURL)
        }
    }

}
