//
//  UserDetails.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 13/03/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import Foundation

class UserDetails {
    
    var id: Int
//    var iconUrl: String
    var name: String
    var email: String
    var rank: Int
    var score: Float
    var correctAnswers: Int
    var wrongAnswers: Int
    
    init(id: Int, name: String, email: String, rank: Int, score: Float, correctAnswers: Int, wrongAnswers: Int) { //, iconUrl: String
        self.id = id
//        self.iconUrl = iconUrl
        self.name = name
        self.email = email
        self.rank = rank
        self.score = score
        self.correctAnswers = correctAnswers
        self.wrongAnswers = wrongAnswers
    }
}
