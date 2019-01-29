//
//  signUpControllerViewController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/18/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit

class signUpController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let authObject = Authentication()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        authObject .userSignUp(user: usernameField.text!, pass: passwordField.text!, email: emailField.text!, deviceID: authObject.getDeviceID()!){ (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        if UserDefaults.standard.string(forKey: "authToken") != nil {
            dismiss(animated: true, completion: nil)
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
