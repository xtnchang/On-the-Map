//
//  UdacityClient.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/18/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import Foundation
import UIKit 

class UdacityClient: NSObject {

    var sessionID : String? = nil 
    var userID : String? = nil
    
    // MARK: GET
    // No URL path parameters required to send requests to server for Udacity API. Only methods are needed. 
    func taskForGETMethod(method: String, completionHandlerForGET: @escaping (_ parsedResponse: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        
        /* 2/3. Build the URL, Configure the request */
        let urlString = Constants.UdacityBaseURL + method
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url as! URL)
      
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
            
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count)))
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            // Parse raw JSON and pass values for (result, error) to completionHandlerForParsingJSON.
            self.parseJSONWithCompletionHandler(newData, completionHandlerForParsingJSON: completionHandlerForGET)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }

    // MARK: POST
    // No URL parameters required to send requests to server for Udacity API, therefore no 'parameters' parameter needed. Only HTTP request message (httpRequestBody) parameter needed.
    func taskForPOSTMethod(method: String, httpRequestBody: String, completionHandlerForPOST: @escaping (_ parsedResponse: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* 2/3. Build the URL, Configure the request */
        let urlString = Constants.UdacityBaseURL + method
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url as! URL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // Convert string to utf8 codes for http request body.
        request.httpBody = httpRequestBody.data(using: String.Encoding.utf8)
        
        let session = URLSession.shared

        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error from the function preceding this closure? */
            guard (error == nil) else {
                sendError(error: "There was an error with your request: \(error!.localizedDescription)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode , statusCode >= 200 && statusCode <= 299 else {
                sendError(error: "The credentials you entered are invalid.")
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError(error: "No data was returned by the request!")
                return
            }
   
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count)))
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.parseJSONWithCompletionHandler(newData, completionHandlerForParsingJSON: completionHandlerForPOST)
            }
    
            /* 7. Start the request */
            task.resume()
        
            return task
    }
    
    func taskForDELETEMethod(method: String, completionHandlerForDELETE: @escaping (_ parsedResponse: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* 2/3. Build the URL, Configure the request */
        let urlString = Constants.UdacityBaseURL + method
        let url = NSURL(string: urlString)
        let request = NSMutableURLRequest(url: url as! URL)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let session = URLSession.shared

        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForDELETE(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
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
            
            let newData = data.subdata(in: Range(uncheckedBounds: (5, data.count)))
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.parseJSONWithCompletionHandler(newData, completionHandlerForParsingJSON: completionHandlerForDELETE)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    

    // given raw JSON, return a usable Foundation object
    // convertDataWithCompletionHandler gets called at the bottom of taskForGETMethod.
    private func parseJSONWithCompletionHandler(_ data: Data, completionHandlerForParsingJSON: (_ parsedResponse: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsedResponse: AnyObject! = nil
        do {
            parsedResponse = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            // Pass in arguments for the completionHandler...and then after the parseJSONWithCompletionHandler function is done running, run completionHandlerForParsingJSON
            completionHandlerForParsingJSON(nil, NSError(domain: "parseJSONWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForParsingJSON(parsedResponse, nil)
    }
    
    // MARK: Shared Instance
    
    class func sharedInstance() -> UdacityClient {
        struct Singleton {
            static var sharedInstance = UdacityClient()
        }
        return Singleton.sharedInstance
    }
}
