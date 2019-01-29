//
//  ViewController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/18/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit
import UserNotifications

class logInController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let authObject = Authentication()
    let nhObject = notificationHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        if UserDefaults.standard.string(forKey: "authToken") != nil {
            performSegue(withIdentifier: "logInSegue", sender: self)
        }
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        authObject.logUserIn(user: usernameField.text!, pass: passwordField.text!, deviceID: authObject.getDeviceID()!){ (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        if UserDefaults.standard.string(forKey: "authToken") != nil {
            UserDefaults.standard.set(usernameField.text!, forKey: "username")
            nhObject.registerForPushNotifications()
            performSegue(withIdentifier: "logInSegue", sender: self)
        }
        
    }

    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
}

