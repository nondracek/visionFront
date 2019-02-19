//
//  ViewController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/18/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit
import UserNotifications
import Firebase

class logInController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let authObject = Authentication()
    let nhObject = notificationHandler()
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        // Firebase Auth Listener
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // What to do when login status changes
            if user != nil {
                if UserDefaults.standard.object(forKey: "notifID") == nil {
                    self.nhObject.registerForPushNotifications()
                }
                self.authObject.sendNotifID()
                self.performSegue(withIdentifier: "logInSegue", sender: self)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        // Close Firebase Auth Listener
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        authObject.logUserIn(email: usernameField.text!, pass: passwordField.text!){ (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
    }

    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
}

