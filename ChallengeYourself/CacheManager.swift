//
//  CacheManager.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 20/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

class CacheManager {
    
    var disciplinesIcons: Dictionary<Int, UIImage> = [Int: UIImage]()
    var leaderboardUsersIcons: Dictionary<Int, UIImage> = [Int: UIImage]()
    
    static let instance = CacheManager()
    private init() {}
    
    // MARK: - Discipline
    
    func insertDisciplineIcon(id: Int, image: UIImage) {
        disciplinesIcons[id] = image
    }
    
    func getDiciplineIcon(id: Int) -> UIImage? {
        let image = disciplinesIcons[id]
        return image
    }
    
    // MARK: - Leaderboard Users
    
    func insertleaderboardUserIcon(id: Int, image: UIImage) {
        leaderboardUsersIcons[id] = image
    }
    
    func getLeaderboardUserIcon(id: Int) -> UIImage? {
        let image: UIImage? = leaderboardUsersIcons[id]
        return image
    }
}
