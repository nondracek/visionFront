//
//  SingleBetController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/21/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit

class SingleBetController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var betTable: UITableView!
    
    let betModel = SingleBet()
    let notifModel = notificationHandler()
    var bets = [allBetReturn]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        betTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            if let allBets = betModel.getBets(userID: userID, completion: {(error) in
                print(error!)
            }) {
                    bets = allBets
                }
            }
        }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "betCell", for: indexPath) as! betCellModel
        cell.titleLabel.text = bets[indexPath.item].title
        cell.participantLabel.text = "Against: " + bets[indexPath.item].participants![1]
        cell.amountLabel.text = "$ \(bets[indexPath.item].amount!)"
        return cell
    }
    
    @IBAction func printBets(_ sender: Any) {
        print(bets)
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count
//    }
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "singleBetCell")! as! singleBetCellController
//        cell.betAmount.text = data[indexPath.row]
//        cell.betName.text = "foo"
//        cell.betParticipants.text = "bob"
//
//        return cell
//    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    @IBAction func createBet(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbNewBetPopUpID") as! CreateBetController
        
        self.addChild(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParent: self)
    }

    struct singleBet: Codable {
        let name: String
        let amount: Float
        let createdBy: String
        let participants: [String]
    }
}

class betCellModel: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var participantLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
