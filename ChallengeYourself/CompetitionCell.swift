//
//  CompetitionTableViewCell.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 08/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

class CompetitionCell: UITableViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func selectDifficultyEasy(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white {
            sender.backgroundColor = UIColor.orange
            sender.setTitleColor(UIColor .white, for: UIControlState.normal)
        } else {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(UIColor .orange, for: UIControlState.normal)
        }
    }
    
    @IBAction func selectDifficultyMedium(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white {
            sender.backgroundColor = UIColor.orange
            sender.setTitleColor(UIColor .white, for: UIControlState.normal)
        } else {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(UIColor .orange, for: UIControlState.normal)
        }
    }
    
    @IBAction func selectDifficultyHard(_ sender: UIButton) {
        
        if sender.backgroundColor == UIColor.white {
            sender.backgroundColor = UIColor.orange
            sender.setTitleColor(UIColor .white, for: UIControlState.normal)
        } else {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(UIColor .orange, for: UIControlState.normal)
        }
    }
}
