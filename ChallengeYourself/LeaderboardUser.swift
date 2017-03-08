//
//  LeaderboardUser.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 03/03/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import Foundation

class LeaderboardUser {
    
    var id: Int
    var name: String
    var email: String
    var rank: Int
    var score: Float
    var iconUrl: String
    
    init(id: Int, name: String, email: String, rank: Int, score: Float, iconUrl: String) {
        self.id = id
        self.name = name
        self.iconUrl = iconUrl
        self.email = email
        self.rank = rank
        self.score = score
    }
}
