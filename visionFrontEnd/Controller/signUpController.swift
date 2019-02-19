//
//  signUpControllerViewController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/18/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit
import Firebase

class signUpController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let authObject = Authentication()
    let NHObject = notificationHandler()
    var handle: AuthStateDidChangeListenerHandle?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Firebase Auth Listener
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // What to do when login status changes
            if let user = user {
                if UserDefaults.standard.object(forKey: "notifID") == nil {
                    self.NHObject.registerForPushNotifications()
                }
                self.authObject.sendNotifID()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        // Close Firebase Auth Listener
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        authObject.userSignUp(pass: passwordField.text!, email: emailField.text!){ (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
