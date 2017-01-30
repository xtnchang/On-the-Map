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
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForSession(nil, NSError(domain: "completionHandlerForPOST", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (results != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let account = results?[JSONResponseKeys.Session] as! [String:AnyObject]? else {
                sendError(error: "No account was found.")
                return
            }
            
            guard let key = account[JSONResponseKeys.ID] as! String? else {
                sendError(error: "No key was found.")
                return
            }
            
            self.userID = key
            
            completionHandlerForSession(key, nil)

        }
        
    }
    
    // Any parameters needed for deleteSession?
    func deleteSession(completionHandlerForDeleteSession: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        taskForDELETEMethod(method: JSONResponseKeys.Session)
        { (results, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForDeleteSession(nil, NSError(domain: "completionHandlerForDELETE", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (results != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let account = results?[JSONResponseKeys.Session] as! [String:AnyObject]? else {
                sendError(error: "No account was found.")
                return
            }
            
            guard let key = account[JSONResponseKeys.ID] else {
                sendError(error: "No key was found.")
                return
            }
            
            completionHandlerForDeleteSession(key, nil)
        }
    }

    func getUserData(completionHandlerForUserData: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) {
    
        taskForGETMethod(method: Methods.User + self.userID!) { (results, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForUserData(nil, NSError(domain: "completionHandlerForGET", code: 1, userInfo: userInfo))
            }
            
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            guard (results != nil) else {
                sendError(error: "No results were found.")
                return
            }
            
            guard let user = results?[JSONResponseKeys.User] as! [String:AnyObject]? else {
                sendError(error: "No account was found.")
                return
            }
            
            completionHandlerForUserData(user as AnyObject?, nil)
        }

        
    }
    
}
