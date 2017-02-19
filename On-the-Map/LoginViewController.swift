//
//  LoginViewController.swift
//  On-the-Map
//
//  Created by Christine Chang on 12/18/16.
//  Copyright © 2016 Christine Chang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        subscribeToKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginPressed(_ sender: AnyObject) {
        
        let username = self.email.text!
        let password = self.password.text!
        
        UdacityClient.sharedInstance().postSession(username: username, password: password) { (success, sessionID, error) in
            
            performUIUpdatesOnMain {
                if success {
                    self.completeLogin()
                } else {
                self.showErrorAlert()
                }
            }
        }
    }

    @IBAction func signUpPressed(_ sender: AnyObject) {
        if let signUpURL = URL(string: "https://auth.udacity.com/sign-up?next=https%3A%2F%2Fclassroom.udacity.com%2Fauthenticated") {
            UIApplication.shared.open(signUpURL)
        }
    }
    
    // MARK: Login
    
    private func completeLogin() {
        
        let controller = storyboard!.instantiateViewController(withIdentifier: "NavigationController") as! UINavigationController
        present(controller, animated: true, completion: nil)
    }

}

// MARK: - Keyboard notifications

extension LoginViewController {
    
    func keyboardWillShow(notification: Notification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: "keyboardWillShow:", name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

}


// MARK: - LoginViewController (Configure UI)

private extension LoginViewController {
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Alert", message: "Your email or password is incorrect", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

