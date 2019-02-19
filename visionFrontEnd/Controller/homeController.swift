//
//  homeController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/18/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit
import ExpandingMenu
import Firebase

class homeController: UIViewController {

    let authObject = Authentication()
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        _ = menuNavigator(currVC: self).getMenu()
        // Firebase Auth Listener
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // What to do when login status changes
            if let user = user {
                print("Home Page")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        // Close Firebase Auth Listener
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        performSegue(withIdentifier: "justGo", sender: self)
    }
    
    @IBAction func logoutPress(_ sender: Any) {
        authObject.userLogOut()
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
