//
//  ParseConstants.swift
//  On-the-Map
//
//  Created by Christine Chang on 1/8/17.
//  Copyright © 2017 Christine Chang. All rights reserved.
//

import Foundation

extension ParseClient {

    //MARK: Constants
    struct Constants {
        
        //MARK: API Key
        static let ParseApiKey: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let ParseApplicationID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        
        //MARK: Parse URL
        static let ParseBaseURL: String = "https://parse.udacity.com/parse/classes/"
    }
    
    // MARK: Methods
    struct Methods {
        
        static let StudentLocation = "StudentLocation"
    }

    // MARK: URL query string parameter keys
    struct ParameterKeys {
        static let Limit = "limit="
        static let Skip = "skip="
        static let Order = "order="
        static let Where = "where="
    }
    
    // MARK: JSON Request Keys (the HTTP request message that the client sends to the server)
    struct JSONRequestKeys {
        
        
    }
    
    // MARK: JSON Response Keys (the HTTP response message that the server sends back to us)
    struct JSONResponseKeys {
        
        static let Results = "results"
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
    }

}


