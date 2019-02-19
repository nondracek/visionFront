//
//  authentication.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/25/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFunctions

class Authentication {
    
    let http = httpModel()
    let notifHandler = notificationHandler()
    
    // Log User In
    func logUserIn(email: String, pass: String, completion:((Error?) -> Void)?) {
        Auth.auth().signIn(withEmail: email, password: pass) { (authResult, error) in
            if let error = error {
                completion?(error)
            }
        }
    }
    
    // Sign User Up
    func userSignUp(pass: String, email: String, completion:((Error?) -> Void)?) {
        Auth.auth().createUser(withEmail: email, password: pass) { (authResult, error) in
            if let error = error {
                completion?(error)
            }
        }
    }
    
    // Log User Out
    func userLogOut() -> Void {
        do {
            try Auth.auth().signOut()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // Try to add NotifID
    func sendNotifID() {
        if UserDefaults.standard.object(forKey: "notifID") == nil {
            self.notifHandler.registerForPushNotifications()
        }
        
        let functions = Functions.functions()
        let body = [
            "deviceID": UserDefaults.standard.string(forKey: "notifID"),
            "deviceOS": "iOS"
        ]
        functions.httpsCallable("userLogin").call(body) { (result, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        }
    }
}
