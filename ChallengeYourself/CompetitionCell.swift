
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
    
    var defaultButtonColor = UIColor .orange
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        easyButton.setTitleColor(defaultButtonColor, for: .normal)
        mediumButton.setTitleColor(defaultButtonColor, for: .normal)
        hardButton.setTitleColor(defaultButtonColor, for: .normal)
        
        easyButton.backgroundColor = UIColor .white
        mediumButton.backgroundColor = UIColor .white
        hardButton.backgroundColor = UIColor .white
    }
    
    func setButtonsBackgroundColor(color: UIColor){
        defaultButtonColor = color
    }
    
    func setButtonsTextColor(color: UIColor) {

        easyButton.setTitleColor(color, for: .normal)
        mediumButton.setTitleColor(color, for: .normal)
        hardButton.setTitleColor(color, for: .normal)
        
    }
    
    @IBAction func selectDifficultyEasy(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white {
            sender.backgroundColor = defaultButtonColor
            sender.setTitleColor(UIColor .white, for: UIControlState.normal)
        } else {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(defaultButtonColor, for: UIControlState.normal)
        }
    }
    
    @IBAction func selectDifficultyMedium(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white {
            sender.backgroundColor = defaultButtonColor
            sender.setTitleColor(UIColor .white, for: UIControlState.normal)
        } else {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(defaultButtonColor, for: UIControlState.normal)
        }
    }
    
    @IBAction func selectDifficultyHard(_ sender: UIButton) {
        
        if sender.backgroundColor == UIColor.white {
            sender.backgroundColor = defaultButtonColor
            sender.setTitleColor(UIColor .white, for: UIControlState.normal)
        } else {
            sender.backgroundColor = UIColor.white
            sender.setTitleColor(defaultButtonColor, for: UIControlState.normal)
        }
    }
}
