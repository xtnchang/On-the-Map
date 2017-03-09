//
//  StudentInfo.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/25/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import Foundation

// Each entry (student) is represented by a struct
struct StudentInfo {
    
    // MARK: JSON request keys needed for POSTing a session
    
    var createdAt: String?
    var firstName: String?
    var lastName: String?
    var latitude: Double?
    var longitude: Double?
    var mapString: String?
    var mediaURL: String?
    var objectID: String?
    var uniqueKey: String?
    var updatedAt: String?
    
    
    // MARK: Initializer (for creating a student instance) that takes a dictionary argument. The dictionary argument is a single student JSON dictionary that get converted to a struct.
    // Each of the struct's properties are set by retrieving the appropriate value (element) from the dictionary argument.
    // To initialize: StudentInfo(dictionary:[createdAt: "2-18", firstName: "Jane"...])
    
    init(dictionary: [String:AnyObject]) {
        
        self.createdAt = dictionary[ParseClient.JSONResponseKeys.CreatedAt] as? String
        self.firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String
        self.lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String
        self.latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Double
        self.longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Double
        self.mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String
        self.mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String
        self.objectID = dictionary[ParseClient.JSONResponseKeys.ObjectId] as? String
        self.uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String
        self.updatedAt = dictionary[ParseClient.JSONResponseKeys.UpdatedAt] as? String
    }
    
    
    // Array of StudentInfo structs stored below. This array gets populated in getStudentLocations.
    static var arrayOfStudentStructs: [StudentInfo] = []
    
    // Placeholder "" to be replaced with a StudentInfo struct as we get the student's info
    static var loggedInUserInfo = ""
    
    //MARK: - TODO create a static var for userInfo:StudentInfo
    // will be populated in :
    // TabViewController - when user taps the pin icon, get first and last name using getUserData (from Udacity). Call UdacityClient.sharedInstance, add userID to userInfo.
    //  AddPinViewController - objectID, mapString
    // AddLinkViewController - longitude and latitude, mediaURL
    
    
}




