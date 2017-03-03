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
            let coordinate = CLLocationCoordinate2D(latitude: placemarks.location.coordinate.latitude, longitude: placemarks.location.coordinate.longitude)
        }
        
        self.mapView.addAnnotation(MKPlacemark(placemark: coordinate))
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        let link = linkTextField.text 
    }
}
