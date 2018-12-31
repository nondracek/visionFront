//
//  CreateBetController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/21/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit

class CreateBetController: UIViewController {

    
    @IBOutlet weak var betName: UITextField!
    @IBOutlet weak var betAmount: UITextField!
    @IBOutlet weak var betParticipant: UITextField!
    
    let betModel = SingleBet()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0.1, alpha: 0.25)
        
    }
    
    
    @IBAction func createBet(_ sender: Any) {
        
        guard let name = betName.text else {
            print("Enter Valid Bet Name")
            return
        }
            
        guard let amountText = betAmount.text else {
            print("Enter Valid Bet Amount")
            return
        }
        
        guard let amount = Float(amountText) else {
            print("Enter Valid Bet Amount")
            return
        }
            
        guard let participant = betParticipant.text else {
            print("Enter Valid Participant")
            return
        }
        
        guard let userID = UserDefaults.standard.string(forKey: "userID") else {
            return
        }
        
        betModel.createBet(creator: userID, amount: amount, otherUser: participant, title: name) {(error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        
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
