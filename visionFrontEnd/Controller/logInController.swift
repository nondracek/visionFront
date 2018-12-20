//
//  ViewController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/18/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit

class logInController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        
        performSegue(withIdentifier: "logInSegue", sender: self)
    }
    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "signUpSegue", sender: self)
    }
    

}

