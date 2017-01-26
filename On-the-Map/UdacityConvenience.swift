//
//  UdacityConvenience.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/18/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import Foundation

extension UdacityClient {

    // The HTTP request message body for postSession contains username & password.
    // The HTTP response message body for postSession contains sessionID.
    func postSession(username: String, password: String, completionHandlerForSession: @escaping (_ result: String?, _ error: NSError?) -> Void) {
        
        // HTTP request message
        let jsonBody = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: String.Encoding.utf8)
        
        taskForPOSTMethod(method: Methods.Session, jsonBody: jsonBody) { (results, error) in
            
            if let error = error {
                completionHandlerForSession(nil, error)
            } else {
                if let session = results?[JSONResponseKeys.Session] {
                    if let sessionID = session[JSONResponseKeys.ID] {
                        completionHandlerForSession(result: sessionID, error: nil)
                    }
                }
            } else {
                completionHandlerForSession(result: nil, error: NSError(domain: "postSession", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse session"]))
            }
        }
        
    }
    
    func deleteSession(completionHandlerForDeleteSession(result: AnyObject?, error: NSError?)) {
        
        taskForDELETEMethod(method: JSONResponseKeys.session)
        { (results, error) in
            
            if let error = error {
                completionHandlerForDeleteSession(nil, error)
            } else {
                if let sessionResults = results[UdacityClient.Session] {
                    if let sessionID = sessionResults[UdacityClient.ID] {
                        completionHandlerForDeleteSession(result: sessionID, error: nil)
                    }
                }
            } else {
                completionHandlerForDeleteSession(result: nil, error: NSError(domain: "deleteSession", code: 0, userInfo: [NSLocalizedDescription: "Could not delete session"]))
            }
        }
    }
    
    func getUserData(username: String, completionHandlerForUserData(result: AnyObject?, error: NSError?)) {
        
        taskForGETMethod(method: Methods.User) { (results, error) in
            
            if let error = error {
                completionHandlerForUserData(nil, error)
            } else {
                if let sessionResults = results[JSONResponseKeys.Session] {
                    if let sessionID = sessionResults[JSONResponseKeys.ID] {
                        completionHandlerForUserData(result: sessionID, error: nil)
                    }
                }
            } else {
                completionHandlerForUserData(result: nil, error: NSError(domain: "postSession", code: 0, userInfo: [NSLocalizedDescription: "Could not parse session"]))
            }
        }
        
    }
    
    
}
