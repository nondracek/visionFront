//
//  ViewController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/18/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit

class logInController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let authObject = Authentication()
    
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
        authObject.logUserIn(user: usernameField.text!, pass: passwordField.text!){ (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        if UserDefaults.standard.string(forKey: "authToken") != nil {
            performSegue(withIdentifier: "logInSegue", sender: self)
        }
        
    }
    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    

}

