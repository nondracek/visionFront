//
//  singleBetCellControllerTableViewCell.swift
//  visionFrontEnd
//
//  Created by Nathan Ondracek on 12/25/18.
//  Copyright © 2018 Surdracek. All rights reserved.
//

import UIKit

class singleBetCellController: UITableViewCell {
    @IBOutlet weak var betName: UILabel!
    @IBOutlet weak var betAmount: UILabel!
    @IBOutlet weak var betParticipants: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
