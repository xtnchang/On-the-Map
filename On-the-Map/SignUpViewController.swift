//
//  SignUpViewController.swift
//  On-the-Map
//
//  Created by Christine Chang on 2/17/17.
//  Copyright © 2017 Christine Chang. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://auth.udacity.com/sign-up?next=https%3A%2F%2Fclassroom.udacity.com%2Fauthenticated")
        let request = URLRequest(url: url!)
        self.webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
