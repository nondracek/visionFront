//
//  SingleBetController.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/21/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit

class SingleBetController: UIViewController, UITableViewDataSource {
    

    @IBOutlet weak var betList: UITableView!
    
    var data = [String]()
    let betModel = SingleBet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        betList.dataSource = self
        betList.rowHeight = self.view.bounds.height / 5
        
        
        for i in 0...1000 {
            data.append("\(i)")
        }
        
        if let userID = UserDefaults.standard.string(forKey: "userID") {
            let bets = betModel.getBets(userID: userID) {(error) in
                print(error!.localizedDescription)
            }
            print(bets)
        }
        
        
        
        menuNavigator(currVC: self)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "singleBetCell")! as! singleBetCellController
        cell.betAmount.text = data[indexPath.row]
        cell.betName.text = "foo"
        cell.betParticipants.text = "bob"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func createNewBet(_ sender: Any) {
        let popUpVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "sbNewBetPopUpID") as! CreateBetController
        
        self.addChild(popUpVC)
        popUpVC.view.frame = self.view.frame
        self.view.addSubview(popUpVC.view)
        popUpVC.didMove(toParent: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    struct singleBet: Codable {
        let name: String
        let amount: Float
        let createdBy: String
        let participants: [String]
    }

}
