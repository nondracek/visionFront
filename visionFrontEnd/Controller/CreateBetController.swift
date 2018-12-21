//
//  CreateBetController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/21/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit

class CreateBetController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0.1, alpha: 0.25)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        self.view.removeFromSuperview()
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
