//
//  ParseConvenience.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/27/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import Foundation

extension ParseClient {
    
    // The JSON response (result) for student locations is an array of dictionaries.
    func getStudentLocations(completionHandlerForLocations: @escaping (_ result: [[String:AnyObject]]?, _ error: NSError?) -> Void) {
        
        taskForGETMethod(method: Methods.StudentLocation, parameters: nil) { (result: [[String:AnyObject]], error: NSError) in
        
            if let error = error {
                completionHandlerForLocations(nil, error)
            } else {
                if let results = result[JSONResponseKeys.Results] as? [[String:AnyObject]]? {
                    completionHandlerForLocations(results, nil)
                }
            } else {
                completionHandlerForLocations(result: nil, error: NSError(domain: "getStudentLocations", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse locations"]))
            }
        }
    }
    
    // Required query string parameter: where=
    func getSingleStudentLocation(completionHandlerForStudentLocation: @escaping (_ result: [[String:AnyObject]]?, _ error: NSError?) -> Void) {
        
        // query string parameters for where=unique_key:1234
        let parameters = [ParameterKeys.Where + JSONResponseKeys.UniqueKey:self.userID]
        
        taskForGETMethod(method: Methods.StudentLocation, parameters: parameters) { (result?, error?) in
            
            if let error = error {
                completionHandlerForStudentLocation(nil, error)
            } else {
                if let results = result[JSONResponseKeys.Results] as? [[String:AnyObject]]? {
                    completionHandlerForStudentLocation(results, nil)
                }
            } else {
                completionHandlerForStudentLocation(result: nil, error: NSError(domain: "getSingleStudentLocation", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse location"]))
            }
        }
    }
    
    func postStudentLocation(uniqueKey: String?, firstName: String?, lastName: String?, mapString: String?, mediaURL: String?, latitude: Int?, longitude: Int?, completionHandlerForPostLocation(result: [String:AnyObject?], error: NSError?)) {
        
        let jsonBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: String.Encoding.utf8)
        
        taskForPOSTMethod(method: Methods.StudentLocation, jsonBody: jsonBody) { (result?, error?) in
        
            if let error = error {
                completionHandlerForPostLocation(nil, error)
            } else {
                if let results = result[JSONResponseKeys.ObjectId] as? String? {
                    completionHandlerForPostLocation(results, nil)
                }
            } else {
                completionHandlerForPostLocation(result: nil, error: NSError(domain: "getSingleStudentLocation", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse location"]))
            }
        }
    
    }
    
    func putStudentLocation(uniqueKey: String?, firstName: String?, lastName: String?, mapString: String?, mediaURL: String?, latitude: Int?, longitude: Int?, completionHandlerForPutLocation(result: [String:AnyObject?], error: NSError?)) {
        
        let jsonBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: String.Encoding.utf8)
        
        taskForPOSTMethod(method: Methods.StudentLocation, jsonBody: jsonBody) { (result?, error?) in
            
            if let error = error {
                completionHandlerForPutLocation(nil, error)
            } else {
                if let results = result[JSONResponseKeys.updatedAt] as? String? {
                    completionHandlerForPutLocation(results, nil)
                }
            } else {
                completionHandlerForPutLocation(result: nil, error: NSError(domain: "getSingleStudentLocation", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse location"]))
            }
        }
    }
    
    
    
    
}
