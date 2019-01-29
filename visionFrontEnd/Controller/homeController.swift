//
//  homeController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/18/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit
import ExpandingMenu

class homeController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        _ = menuNavigator(currVC: self).getMenu()
    }
    
    @IBAction func buttonPress(_ sender: Any) {
        performSegue(withIdentifier: "justGo", sender: self)
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
