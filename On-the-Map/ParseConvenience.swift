//
//  ParseConvenience.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/27/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import Foundation
import UIKit 

extension ParseClient {
    
    // The JSON response (result) for GETting all student locations is a dictionary.
    // The 'result' parameter is an array of dictionaries (each dictionary is a student)
    func getStudentLocations(completionHandlerForLocations: @escaping (_ studentLocations: [[String:AnyObject]]?, _ error: NSError?) -> Void) {
        
        // No query string parameters required, since you're not requesting a specific location.
        // The 'results' parameter is the encompassing data structure type, the "results" dictionary.
        taskForGETMethod(method: Methods.StudentLocation, parameters: nil) { (parsedResult, error) in
        
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForLocations(nil, NSError(domain: "completionHandlerForGET", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (parsedResult != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let studentLocations = parsedResult?[JSONResponseKeys.Results] as? [[String:AnyObject]]? else {
                sendError(error: "No results were found.")
                return
            }
            
            completionHandlerForLocations(studentLocations, nil)
               
        }
    }
    
    // The 'result' parameter is an array containing a single dictionary (single student)
    func getSingleStudentLocation(completionHandlerForStudentLocation: @escaping (_ studentLocation: [[String:AnyObject]]?, _ error: NSError?) -> Void) {
        
        // query string parameters for where=unique_key:1234
        let parameters = "\(ParameterKeys.Where)%7B%22\(JSONResponseKeys.UniqueKey)%22%3A%22\(UdacityClient.sharedInstance().userID)%22%7D"
        
        // The 'results' parameter is the "results" dictionary
        taskForGETMethod(method: Methods.StudentLocation, parameters: parameters) { (parsedResult, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForStudentLocation(nil, NSError(domain: "completionHandlerForGET", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (parsedResult != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let studentLocation = parsedResult?[JSONResponseKeys.Results] as? [[String: AnyObject]] else {
                sendError(error: "No results were found.")
                return
            }
            
            completionHandlerForStudentLocation(studentLocation, nil)
        }
    }
    
    // The 'result' parameter is the string value for either "objectId" or "createdAt"
    func postStudentLocation(uniqueKey: String?, firstName: String?, lastName: String?, mapString: String?, mediaURL: String?, latitude: Int?, longitude: Int?, completionHandlerForPostLocation: @escaping (_ objectID: String?, _ error: NSError?) -> Void) {
        
        // Create JSON request body (String -> Data)
        let jsonBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: String.Encoding.utf8)
        
        // The 'results' parameter is the dictionary with keys createdAt and objectId.
        taskForPOSTMethod(method: Methods.StudentLocation, jsonBody: jsonBody!) { (parsedResult, error) in
        
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForPostLocation(nil, NSError(domain: "completionHandlerForPOST", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (parsedResult != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let objectID = parsedResult?[JSONResponseKeys.ObjectId] as! String? else {
                sendError(error: "No results were found.")
                return
            }
            
            self.objectID = objectID

            completionHandlerForPostLocation(objectID, nil)
        }
    }
 
    // The 'result' parameter is the string value for either "updatedAt"
    func putStudentLocation(uniqueKey: String?, firstName: String?, lastName: String?, mapString: String?, mediaURL: String?, latitude: Int?, longitude: Int?, completionHandlerForPutLocation: @escaping (_ updatedAt: String?, _ error: NSError?) -> Void) {
        
        // Create JSON request body (String -> Data)
        let jsonBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: String.Encoding.utf8)
        
        // The 'results' parameter is a dictionary with a single key, updatedAt
        taskForPUTMethod(method: Methods.StudentLocation, parameters: self.objectID!, jsonBody: jsonBody!) { (parsedResult, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForPutLocation(nil, NSError(domain: "completionHandlerForPUT", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (parsedResult != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let updatedAt = parsedResult?[JSONResponseKeys.UpdatedAt] as! String? else {
                sendError(error: "No results were found.")
                return
            }
            
            completionHandlerForPutLocation(updatedAt, nil)
        }
    }
    
}
