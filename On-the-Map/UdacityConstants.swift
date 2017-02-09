//
//  Constants.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/18/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import Foundation

extension UdacityClient {
    
    
    //MARK: Constants
    struct Constants {
        
        //MARK: Udacity URL
        static let UdacityBaseURL: String = "https://www.udacity.com/api/"
    }
    
    // MARK: Methods
    struct Methods {

        static let Session = "session"
        static let User = "users/"
    }
    
    // MARK: URL query string parameter keys....none for Udacity API
    
    // MARK: JSON Request Keys (the HTTP request message that the client sends to the server)
    struct JSONRequestKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    // MARK: JSON Response Keys (the HTTP response message that the server sends back to us)
    // These keys are found in the Supporting Materials JSON links at the bottom of each page.
    struct JSONResponseKeys {
        static let Account = "account"
        static let Registered = "registered"
        static let Key = "key"
        static let Session = "session"
        static let ID = "id"
        static let Expiration = "expiration"
        static let User = "user"
        static let FirstName =  "first_name"
        static let LastName = "last_name"
    }
}







