//
//  LeaderboardCell.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 03/03/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var userPhoto: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
