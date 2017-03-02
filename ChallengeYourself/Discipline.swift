//
//  Discipline.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 20/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import Foundation

class Discipline {
    
    var id: Int
    var name: String
    var iconUrl: String
    var color: String
    var easyDifficulty: Int
    var mediumDifficulty: Int
    var hardDifficulty: Int
    
    init(id: Int, name: String, iconUrl: String, color: String, easyDifficulty: Int, mediumDifficulty: Int, hardDifficulty: Int) {
        self.id = id
        self.name = name
        self.iconUrl = iconUrl
        self.color = color
        self.easyDifficulty = easyDifficulty
        self.mediumDifficulty = mediumDifficulty
        self.hardDifficulty = hardDifficulty
    }
}
