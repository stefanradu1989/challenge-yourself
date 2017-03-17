//
//  AnswerCell.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 16/03/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit
/* protocol for delegate is implemented just in case it is needed
protocol AnswerCellDelegate: class {
    func cellDidUpdateCurrentSelectedAnswer(cell: AnswerCell)
}
*/
class AnswerCell: UITableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    
//    in case it is needed
//    weak var delegate: AnswerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
