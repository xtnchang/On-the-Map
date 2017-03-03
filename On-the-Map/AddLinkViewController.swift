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
    
    @IBOutlet weak var linkTextField: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // self.mapView.addAnnotation(MKPlacemark(placemark: coordinate))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        let link = linkTextField.text 
    }
}
