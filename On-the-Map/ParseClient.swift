//
//  ParseClient.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/27/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import Foundation
import UIKit 


class ParseClient: NSObject {

    var sessionID : String? = nil
    var userID : String? = nil
    var objectID: String? = nil 
    
    // MARK: GET
    // 'parameters' parameter is for query string parameters
    func taskForGETMethod(method: String, parameters: String?, completionHandlerForGET: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        /* 2/3. Build the URL, Configure the request */
        let urlString = Constants.ParseBaseURL + method + parameters!
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url as! URL)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = URLSession.shared
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey: error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError(error: "No data was returned by the request!")
                return
            }
            
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count - 5)))
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            // Parse raw JSON and pass values for (result, error) to completionHandlerForParsing.
            self.parseJSONWithCompletionHandler(data: newData as NSData, completionHandlerForParsingJSON: completionHandlerForGET)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    // MARK: POST
    func taskForPOSTMethod(method: String, jsonBody: Data?, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* 2/3. Build the URL, Configure the request */
        let urlString = Constants.ParseBaseURL + method
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url as! URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBody 
        
        let session = URLSession.shared
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError(error: "No data was returned by the request!")
                return
            }
            
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count - 5)))
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.parseJSONWithCompletionHandler(data: newData as NSData, completionHandlerForParsingJSON: completionHandlerForPOST)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    // MARK: PUT
    // 'parameters' parameter is for {objectId} path parameter
    func taskForPUTMethod(method: String, parameters: String, jsonBody: Data?, completionHandlerForPUT: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* 2/3. Build the URL, Configure the request */
        let urlString = Constants.ParseBaseURL + method + parameters
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url as! URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBody 
        
        let session = URLSession.shared
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPUT(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "Your request returned a status code other than 2xx!")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError(error: "No data was returned by the request!")
                return
            }
            
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count - 5)))
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.parseJSONWithCompletionHandler(data: newData as NSData, completionHandlerForParsingJSON: completionHandlerForPUT)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }

    

    // given raw JSON, return a usable Foundation object
    // convertDataWithCompletionHandler gets called at the bottom of taskForGETMethod.
    private func parseJSONWithCompletionHandler(data: NSData, completionHandlerForParsingJSON: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResult: Any
        do {
            parsedResult = try JSONSerialization.jsonObject(with: (data as NSData) as Data, options: .allowFragments)
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            // Pass in arguments for the completionHandler...and then after the parseJSONWithCompletionHandler function is done running, run completionHandlerForParsingJSON
            completionHandlerForParsingJSON(nil, NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForParsingJSON(parsedResult as AnyObject?, nil)
    }
    
//    // create a URL from parameters
//    private func generatePathParameters(parameters: [String:AnyObject]) -> String {
//        
//        var pathArray = [String?]()
//        
//        for (key, value) in parameters {
//            let string = "where=" + "\(key)" + "\(value)"
//            pathArray.append(string)
//        }
//        
//        return pathArray.joined(separator: "&")
//    }
    
    // MARK: Shared Instance
    
    func sharedInstance() -> ParseClient {
        struct Singleton {
            static var sharedInstance = ParseClient()
        }
        return Singleton.sharedInstance
    }
}
