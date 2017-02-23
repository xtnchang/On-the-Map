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
    
    var createdAt: String
    var firstName: String
    var lastName: String
    var latitude: Int?
    var longitude: Int?
    var mapString: String
    var mediaURL: String
    var objectID: String
    var uniqueKey: String
    var updatedAt: String
    
    
    // MARK: Initializer (for creating a student instance) that takes a dictionary argument. The dictionary argument is a single student JSON dictionary that get converted to a struct.
    // Each of the struct's properties are set by retrieving the appropriate value (element) from the dictionary argument.
    // To initialize: StudentInfo(dictionary:[createdAt: "2-18", firstName: "Jane"...])
    
    init(dictionary: [String:AnyObject]) {
        
        self.createdAt = dictionary[ParseClient.JSONResponseKeys.CreatedAt] as? String ?? "n/a"
        self.firstName = dictionary[ParseClient.JSONResponseKeys.FirstName] as? String ?? "n/a"
        self.lastName = dictionary[ParseClient.JSONResponseKeys.LastName] as? String ?? "n/a"
        self.latitude = dictionary[ParseClient.JSONResponseKeys.Latitude] as? Int
        self.longitude = dictionary[ParseClient.JSONResponseKeys.Longitude] as? Int
        self.mapString = dictionary[ParseClient.JSONResponseKeys.MapString] as? String ?? "n/a"
        self.mediaURL = dictionary[ParseClient.JSONResponseKeys.MediaURL] as? String ?? "n/a"
        self.objectID = dictionary[ParseClient.JSONResponseKeys.ObjectId] as? String ?? "n/a"
        self.uniqueKey = dictionary[ParseClient.JSONResponseKeys.UniqueKey] as? String ?? "n/a"
        self.updatedAt = dictionary[ParseClient.JSONResponseKeys.UpdatedAt] as? String ?? "n/a"
    }
    
    
    // Array of StudentInfo structs stored below
    static var arrayOfStudentStructs: [StudentInfo] = []
    
}




