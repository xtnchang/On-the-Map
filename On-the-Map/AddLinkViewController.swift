//
//  AddLinkViewController.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/25/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class AddLinkViewController: UIViewController {
    
    var firstName: String?
    var lastName: String?
    var mapString: String?
    var mediaURL: String?
    var latitude: Double?
    var longitude: Double?
    
    var objectID: String?
    
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        showPinOnMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getObjectID()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPinOnMap() {
        
        geocoder.geocodeAddressString(mapString!) { (placemarks, error) in
            
            // Must unwrap the placemark. Placemarks is an array of potential locations for the entered name. The first property retrieves the first result.
            if let placemark = placemarks?.first  {
                
                // Convert CLPlacemark to MKPlacemark so that we can add it to mapView.
                let mapKitPlacemark = MKPlacemark(placemark: placemark)
                self.mapView.addAnnotation(mapKitPlacemark)
                
                // Get latitude and longitude values from placemark
                self.latitude = placemark.location?.coordinate.latitude
                self.longitude = placemark.location?.coordinate.longitude
            }
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        
        let loggedInUser: String = "{\"uniqueKey\": \"\(UdacityClient.sharedInstance().userID)\", \"firstName\": \"\(self.firstName)\", \"lastName\": \"\(self.lastName)\",\"mapString\": \"\(self.mapString)\", \"mediaURL\": \"\(self.linkTextField.text)\",\"latitude\": \(self.latitude), \"longitude\": \(self.longitude)}"
        
        // This dictionary contains the contents required for the http request body.
//        let loggedInUser: [String: AnyObject] = [
//            ParseClient.JSONRequestKeys.UniqueKey: UdacityClient.sharedInstance().userID as AnyObject,
//            ParseClient.JSONRequestKeys.FirstName: self.firstName as AnyObject,
//            ParseClient.JSONRequestKeys.LastName: self.lastName as AnyObject,
//            ParseClient.JSONRequestKeys.MapString: self.mapString as AnyObject,
//            ParseClient.JSONRequestKeys.MediaURL: self.linkTextField.text as AnyObject,
//            ParseClient.JSONRequestKeys.Latitude: self.latitude as AnyObject,
//            ParseClient.JSONRequestKeys.Longitude: self.longitude as AnyObject
//        ]
        
        // MARK: TO-DO
        // If objectID exists, use Parse's PUT method to update student location with objectID in URL. Pass in loggedInUser dictionary.
        // If objectID doesn't exist, use Parse's POST method to create a new student location. Pass in loggedInUser dictionary.
        // Do I need to do anything with the objectID value returned in the response body?
        
        // Dismiss the modal view and go back to TabViewController.
        
        if self.objectID != nil {
            
            ParseClient.sharedInstance().putStudentLocation(studentDictionary: loggedInUser) { (updatedAt, error) in
                
                performUIUpdatesOnMain {
                    if error == nil {
                        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                    } else {
                        self.showErrorAlert(message: "There was an error updating your pin.")
                    }
                }
            }
            
        } else {
            
            ParseClient.sharedInstance().postStudentLocation(studentDictionary: loggedInUser) { (objectID, error) in
                
                performUIUpdatesOnMain {
                    if error == nil {
                        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                    } else {
                        self.showErrorAlert(message: "There was an error posting your pin.")
                    }
                }
            }
        }
    }
    
    func getObjectID () {
        
        ParseClient.sharedInstance().getSingleStudentLocation() { (studentLocation, error) in
            
            // If there's an error, just return out of this function?
            if (error != nil) {
                return
            }
            
            // Access the first (and only) dictionary in the array.
            let dictionary = studentLocation![0]
            
            // Unwrap the objectID
            guard let objectID = dictionary[ParseClient.JSONResponseKeys.ObjectId] as? String else {
                print("objectID not found")
                return
            }
            
            self.objectID = objectID
        }
    }
}

private extension AddLinkViewController {
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
