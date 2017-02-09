//
//  LoggedInUser.swift
//  On-the-Map
//
//  Created by Christine Chang on 2/9/17.
//  Copyright © 2017 Christine Chang. All rights reserved.
//

import Foundation

// Create an instance of this struct when user presses login button

// Once the user logs in with email + password (via Udacity), we get their user info (firstName, lastName, uniqueKey).
struct LoggedInUser {
    
    var firstName: String
    var lastName: String
    var uniqueKey: String
    
    init(dictionary: [String:AnyObject]) {
        
        // Access the "user" key in the GETting public user data JSON response
        let user = dictionary[UdacityClient.JSONResponseKeys.User] as! [String: AnyObject]
        
        // Access the first name, last name, and key in the "user" dictionary.
        self.firstName = user[UdacityClient.JSONResponseKeys.FirstName] as! String
        self.lastName = user[UdacityClient.JSONResponseKeys.LastName] as! String
        self.uniqueKey = user[UdacityClient.JSONResponseKeys.Key] as! String
    }
    
}

