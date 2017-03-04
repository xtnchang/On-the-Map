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
    
    var enteredLocation: String?
    
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
        
        geocoder.geocodeAddressString(enteredLocation!) { (placemarks, error) in
            
            // Must unwrap the placemark. Placemarks is an array of potential locations for the entered name. The first property retrieves the first result.
            if let placemark = placemarks?.first  {
                
                // Convert CLPlacemark to MKPlacemark
                let thePlacemark = MKPlacemark(placemark: placemark)
                self.mapView.addAnnotation(thePlacemark)
            }
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        let link = linkTextField.text 
    }
}
