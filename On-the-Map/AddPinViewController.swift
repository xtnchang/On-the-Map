//
//  AddPinViewController.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/18/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class AddPinViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    
    var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocationPressed(_ sender: Any) {
        let location = locationTextField.text
        
//        geocoder.geocodeAddressString(location!) { (placemarks, error) in
//            let coordinate = CLLocationCoordinate2D(latitude: placemarks.location.coordinate.latitude, longitude: placemarks.location.coordinate.longitude)
//        }
    }
}
