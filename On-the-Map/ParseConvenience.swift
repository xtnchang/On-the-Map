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
    func getStudentLocations(completionHandlerForLocations: @escaping (_ result: [[String:AnyObject]]?, _ error: NSError?) -> Void) {
        
        // No query string parameters required, since you're not requesting a specific location.
        // The 'results' parameter is the encompassing data structure type, the "results" dictionary.
        taskForGETMethod(method: Methods.StudentLocation, parameters: nil) { (results: [String: AnyObject]?, error: NSError?) in
        
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForLocations(nil, NSError(domain: "completionHandlerForGET", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (results != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            // 'results' on the left is a new constant, 'results?' on the right refers to the closure argument.
            guard let results = results?[JSONResponseKeys.Results] as? [[String:AnyObject]]? else {
                sendError(error: "No results were found.")
                return
            }
            
            // for loop iterating through each dictionary in the array of dictionaries. Convert each dictionary into a StudentInfo struct.
            
            var studentInfoArray = [[String:AnyObject]]()
            
            for dictionary in results! {
                let studentStruct = StudentInfo(dictionary: dictionary)
                studentInfoArray.append(studentStruct)
            }
            
            completionHandlerForLocations(results, nil)
               
        }
    }
    
    // The 'result' parameter is an array of a single dictionary (single student)
    func getSingleStudentLocation(completionHandlerForStudentLocation: @escaping (_ result: [[String:AnyObject]]?, _ error: NSError?) -> Void) {
        
        // query string parameters for where=unique_key:1234
        let parameters = ParameterKeys.Where + "%7B%22" + JSONResponseKeys.UniqueKey + "%22%3A%22" + results?[JSONResponseKeys.UniqueKey] + "%22%7D"
        
        // The 'results' parameter is the "results" dictionary
        taskForGETMethod(method: Methods.StudentLocation, parameters: parameters) { (results: [String: AnyObject]?, error: NSError?) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForStudentLocation(nil, NSError(domain: "completionHandlerForGET", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (results != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let results = results?[JSONResponseKeys.Results] as? [[String: AnyObject]] else {
                sendError(error: "No results were found.")
                return
            }
            
            completionHandlerForStudentLocation(results, nil)
        }
    }
    
    // The 'result' parameter is the string value for either "objectId" or "createdAt"
    func postStudentLocation(uniqueKey: String?, firstName: String?, lastName: String?, mapString: String?, mediaURL: String?, latitude: Int?, longitude: Int?, completionHandlerForPostLocation: @escaping (_ result: String?, _ error: NSError?) -> Void) {
        
        // Create JSON request body (String -> Data)
        let jsonBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: String.Encoding.utf8)
        
        // The 'results' parameter is the dictionary with keys createdAt and objectId.
        taskForPOSTMethod(method: Methods.StudentLocation, jsonBody: jsonBody!) { (results: [String: AnyObject]?, error: NSError?) in
        
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForPostLocation(nil, NSError(domain: "completionHandlerForPOST", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (results != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let results = results?[JSONResponseKeys.ObjectId] as! String? else {
                sendError(error: "No results were found.")
                return
            }
            
            self.objectID = results

            completionHandlerForPostLocation(results, nil)
        }
    }
 
    // The 'result' parameter is the string value for either "updatedAt"
    func putStudentLocation(uniqueKey: String?, firstName: String?, lastName: String?, mapString: String?, mediaURL: String?, latitude: Int?, longitude: Int?, completionHandlerForPutLocation: @escaping (_ result: String?
        , _ error: NSError?) -> Void) {
        
        // Create JSON request body (String -> Data)
        let jsonBody = "{\"uniqueKey\": \"\(uniqueKey)\", \"firstName\": \"\(firstName)\", \"lastName\": \"\(lastName)\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: String.Encoding.utf8)
        
        // The 'results' parameter is a dictionary with a single key, updatedAt
        taskForPUTMethod(method: Methods.StudentLocation, parameters: self.objectId, jsonBody: jsonBody!) { (results: [String: AnyObject]?, error: NSError?) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForPutLocation(nil, NSError(domain: "completionHandlerForPUT", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (results != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let results = results?[JSONResponseKeys.UpdatedAt] as! String? else {
                sendError(error: "No results were found.")
                return
            }
            
            completionHandlerForPutLocation(results, nil)
        }
    }
    
}
