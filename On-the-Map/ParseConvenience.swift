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
    // The studentInfoArray parameter is an array of dictionaries (each dictionary is a student)
    func getStudentLocations(completionHandlerForLocations: @escaping (_ success: Bool, _ studentInfoArray: [StudentInfo]?, _ error: NSError?) -> Void) {
        
        // query string parameters for limit=100.
        let parameters = "?\(ParameterKeys.Limit)100"
        
        // The parsedResponse parameter is the encompassing data structure type, the "results" dictionary.
        let _ = taskForGETMethod(method: Methods.StudentLocation, parameters: parameters) { (parsedResponse, error) in
        
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForLocations(false, nil, NSError(domain: "completionHandlerForGET", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (parsedResponse != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            // drill down to the array of student location dictionaries
            guard let studentLocations = parsedResponse?[JSONResponseKeys.Results] as? [[String:AnyObject]]? else {
                sendError(error: "No results were found.")
                return
            }
            
            // empty array to be populated with StudentInfo structs (stored in StudentInfo.swift)
            var studentInfoArray = StudentInfo.arrayOfStudentStructs
            
            // Convert each student dictionary (parsed JSON) to a StudentInfo struct.
            for student in studentLocations! {
                let studentStruct = StudentInfo(dictionary: student)
                studentInfoArray.append(studentStruct)
            }
            
            completionHandlerForLocations(true, studentInfoArray, nil)
               
        }

    }
    
    // The studentLocation parameter is an array containing a single dictionary (of the logged in user).
    func getSingleStudentLocation(completionHandlerForStudentLocation: @escaping (_ studentLocation: [[String:AnyObject]]?, _ error: NSError?) -> Void) {
        
        // query string parameters for where=unique_key:1234. The unique key is stored in the UdacityClient userID property.
        let parameters = "\(ParameterKeys.Where)%7B%22\(JSONResponseKeys.UniqueKey)%22%3A%22\(UdacityClient.sharedInstance().userID!)%22%7D"
        
        // The 'results' parameter is the "results" dictionary
        let _ = taskForGETMethod(method: Methods.StudentLocation, parameters: parameters) { (parsedResponse, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForStudentLocation(nil, NSError(domain: "completionHandlerForGET", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (parsedResponse != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let studentLocation = parsedResponse?[JSONResponseKeys.Results] as? [[String: AnyObject]] else {
                sendError(error: "No results were found.")
                return
            }
            
            /*** Should I unwrap the objectID? ***/
            
//            guard let dictionary = studentLocation[0] as? [String: AnyObject] else {
//                sendError(error: "No results were found.")
//                return
//            }
//            
//            guard let objectID = dictionary[JSONResponseKeys.ObjectId] as? String else {
//                sendError(error: "No objectID found.")
//                return
//            }
            
            completionHandlerForStudentLocation(studentLocation, nil)
        }
    }
    
    // When POSTing a studentLocation, we'll get an "objectID" value in the http response.
    func postStudentLocation(studentDictionary: String, completionHandlerForPostLocation: @escaping (_ objectID: String?, _ error: NSError?) -> Void) {
        
        // The parsedResponse parameter is the dictionary with keys createdAt and objectId.
        // studentDictionary must be converted to JSON to be sent to the server.
        let _ = taskForPOSTMethod(method: Methods.StudentLocation, httpRequestBody: studentDictionary) { (parsedResponse, error) in
        
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForPostLocation(nil, NSError(domain: "completionHandlerForPOST", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (parsedResponse != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let objectID = parsedResponse?[JSONResponseKeys.ObjectId] as! String? else {
                sendError(error: "No results were found.")
                return
            }
            
            self.objectID = objectID

            completionHandlerForPostLocation(objectID, nil)
        }
    }
 
    // When PUTting a studentLocation, we'll get an "updatedAt" value in the http response.
    func putStudentLocation(studentDictionary: String, completionHandlerForPutLocation: @escaping (_ updatedAt: String?, _ error: NSError?) -> Void) {
        
        // The parsedResponse parameter is a dictionary with a single key, updatedAt
        let _ = taskForPUTMethod(method: Methods.StudentLocation, parameters: self.objectID!, httpRequestBody: studentDictionary) { (parsedResponse, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForPutLocation(nil, NSError(domain: "completionHandlerForPUT", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (parsedResponse != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let updatedAt = parsedResponse?[JSONResponseKeys.UpdatedAt] as! String? else {
                sendError(error: "No results were found.")
                return
            }
            
            completionHandlerForPutLocation(updatedAt, nil)
        }
    }
    
}
