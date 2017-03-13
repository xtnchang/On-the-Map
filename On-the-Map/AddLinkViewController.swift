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
    
    @IBOutlet weak var linkTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        showPinOnMap()
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
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        
        let loggedInUser: [String: AnyObject] = [
            ParseClient.JSONRequestKeys.UniqueKey: UdacityClient.sharedInstance().userID as AnyObject,
            ParseClient.JSONResponseKeys.LastName: self.lastName as AnyObject,
            ParseClient.JSONRequestKeys.MapString: self.mapString as AnyObject,
            ParseClient.JSONRequestKeys.MediaURL: self.linkTextField.text as AnyObject,
            ParseClient.JSONRequestKeys.Latitude: self.latitude as AnyObject,
            ParseClient.JSONRequestKeys.Longitude: self.longitude as AnyObject
        ]
        
        // MARK: TO-DO
        // If objectID exists, use Parse's PUT method to update student location with objectID in URL. Pass in loggedInUser dictionary.
        // Do I need to do anything with the updatedAt value returned in the response body?
        
        // If objectID doesn't exist, use Parse's POST method to create a new student location. Pass in loggedInUser dictionary.
        // Do I need to do anything with the objectID value returned in the response body?
        
        // Dismiss the modal view and go back to TabViewController.
        self.dismiss(animated: true, completion: nil)
    }
}
