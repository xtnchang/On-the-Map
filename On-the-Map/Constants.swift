//
//  Constants.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/18/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import Foundation

extension Client {
    
    
    //MARK: Constants
    struct Constants {
        
        //MARK: API Key
        static let ParseApiKey : String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ParseApplicationID = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        
        //MARK: Udacity URL
        static let UdacityApiScheme = "https"
        static let UdacityApiHost = "www.udacity.com"
        static let UdacityApiPath = "api"
        static let UdacityAuthorizationURL: String = "https://www.udacity.com/api/session"
        
        //MARK: Parse URL
        static let ParseApiScheme = "https"
        static let ParseApiHost = "parse.udacity.com"
        static let ParseApiPath = "parse"
        static let ParseAuthorizationURL: String = "https://parse.udacity.com/parse/classes/StudentLocation"
    }
    
    // MARK: Methods
    struct Methods {

        static let UpdateLocation = "/<objectId>"
        static let GetUserData = "/<user_id>"
    }
    
    //MARK: StudentLocation (Parse API) parameter keys
    struct StudentLocationParameterKeys {
        static let Limit = "?limit="
        static let Skip = "???"
        static let Order = "?order="
        static let Where = "?where="
        static let ObjectId = ""
        static let ApiKey = "api_key"
    }
    
    //MARK: StudentLocation (Parse API) parameter values
    struct StudentLocationParameterValues {
        static let Limit = "100"
        static let Skip = "?limit=200&skip=400"
        static let Order = "-updatedAt"
        static let Where = "=%7B%22uniqueKey%22%3A%221234%22%7D"
        static let ObjectId: String
    }
    
    //MARK: User (Udacity API) parameter keys
    struct UserParameterKeys {
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
    }
    
    //MARK: Student parameter keys
    struct StudentParameterKeys {
        
        static let ObjectId = "objectId"
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let CreatedAt = "createdAt"
        static let UpdatedAt = "updatedAt"
        static let ACL = "ACL"
    }
        

}







