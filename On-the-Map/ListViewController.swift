//
//  ListViewController.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/20/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    
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
        return StudentInfo.arrayOfStudentStructs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentNameCell")!
        let student = StudentInfo.arrayOfStudentStructs[indexPath.row]
        
        // Since each student is a struct, not an array, use dot syntax rather than bracket subscript syntax.
        cell.textLabel?.text = student.firstName
        
        return cell
    }
    
    // MARK: UITableViewDelegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let student = StudentInfo.arrayOfStudentStructs[indexPath.row]
        
        if let studentURL = URL(string: student.mediaURL!) {
            
            if UIApplication.shared.canOpenURL(studentURL) {
                UIApplication.shared.open(studentURL)
            } else {
                self.showErrorAlert(messageText: "Not a valid URL.")
            }
        }
    }
}

private extension ListViewController {
    
    func showErrorAlert(messageText: String) {
        let alert = UIAlertController(title: "Alert", message: messageText, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
