
//  CompetitionTableViewCell.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 08/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

protocol CompetitionCellDelegate: class {
    func cellDidUpdateDifficultySelection(cell: CompetitionCell, difficulty: String, selected: Bool)
}

class CompetitionCell: UITableViewCell {

    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    var defaultButtonColor = UIColor .orange
    
    weak var delegate: CompetitionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Difficulty Buttons Actions
    
    @IBAction func selectDifficultyEasy(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white {
            setEasyButtonValue(selected: true)
            delegate?.cellDidUpdateDifficultySelection(cell: self, difficulty: "easy", selected: true)
        } else {
            setEasyButtonValue(selected: false)
            delegate?.cellDidUpdateDifficultySelection(cell: self, difficulty: "easy", selected: false)
        }
    }
    
    @IBAction func selectDifficultyMedium(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white {
            setMediumButtonValue(selected: true)
            delegate?.cellDidUpdateDifficultySelection(cell: self, difficulty: "medium", selected: true)
        } else {
            setMediumButtonValue(selected: false)
            delegate?.cellDidUpdateDifficultySelection(cell: self, difficulty: "medium", selected: false)
        }
    }
    
    @IBAction func selectDifficultyHard(_ sender: UIButton) {
        if sender.backgroundColor == UIColor.white {
            setHardButtonValue(selected: true)
            delegate?.cellDidUpdateDifficultySelection(cell: self, difficulty: "hard", selected: true)
        } else {
            setHardButtonValue(selected: false)
            delegate?.cellDidUpdateDifficultySelection(cell: self, difficulty: "hard", selected: false)
        }
    }
    
    // MARK: - Setters
    
    func setButtonsBackgroundColor(color: UIColor){
        defaultButtonColor = color
    }
    
    func setButtonsTextColor(color: UIColor) {
        easyButton.setTitleColor(color, for: .normal)
        mediumButton.setTitleColor(color, for: .normal)
        hardButton.setTitleColor(color, for: .normal)
    }
    
    func setEasyButtonValue(selected: Bool) {
        if selected{
            easyButton.backgroundColor = titleLabel.textColor
            easyButton.setTitleColor(UIColor .white, for: UIControlState.normal)
        } else {
            easyButton.backgroundColor = UIColor .white
            easyButton.setTitleColor(titleLabel.textColor, for: UIControlState.normal)
        }
    }
    
    func setMediumButtonValue(selected: Bool) {
        if selected{
            mediumButton.backgroundColor = titleLabel.textColor
            mediumButton.setTitleColor(UIColor .white, for: UIControlState.normal)
        } else {
            mediumButton.backgroundColor = UIColor .white
            mediumButton.setTitleColor(titleLabel.textColor, for: UIControlState.normal)
        }
    }
    
    func setHardButtonValue(selected: Bool) {
        if selected{
            hardButton.backgroundColor = titleLabel.textColor
            hardButton.setTitleColor(UIColor .white, for: UIControlState.normal)
        } else {
            hardButton.backgroundColor = UIColor .white
            hardButton.setTitleColor(titleLabel.textColor, for: UIControlState.normal)
        }
    }
}
