//
//  ParseUtils.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 21/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import Foundation
import SwiftyJSON

class ParseUtils {
    
    // MARK: - Disciplines
    
    static var disciplinesArray: [Discipline] = []
    
    static func parseDisciplinesList(disciplines: [AnyObject]) -> [Discipline] {
        
        for disciplineJson in disciplines {
            let discipline = JSON(disciplineJson)
            print("[ParseUtils] discipline: \(discipline)")
            
            var disciplineItem: Discipline
            
            if DataManager.instance.disciplinesDictionary[discipline["disciplineId"].intValue] == nil {
                
                disciplineItem = Discipline(id: discipline["disciplineId"].intValue, name: discipline["disciplineName"].stringValue, iconUrl: discipline["disciplineIcon"].stringValue, color: discipline["disciplineColor"].stringValue, easyDifficulty: 0, mediumDifficulty: 0, hardDifficulty: 0)
                
                switch discipline["difficulty"].stringValue {
                case "easy":
                    disciplineItem.easyDifficulty = discipline["questionCount"].intValue
                    break
                case "medium":
                    disciplineItem.mediumDifficulty = discipline["questionCount"].intValue
                    break
                case "hard":
                    disciplineItem.hardDifficulty = discipline["questionCount"].intValue
                    break
                default:
                    break
                }
            } else {
                disciplineItem = DataManager.instance.disciplinesDictionary[discipline["disciplineId"].intValue]!
                
                switch discipline["difficulty"].stringValue {
                case "easy":
                    disciplineItem.easyDifficulty = discipline["questionCount"].intValue
                    break
                case "medium":
                    disciplineItem.mediumDifficulty = discipline["questionCount"].intValue
                    break
                case "hard":
                    disciplineItem.hardDifficulty = discipline["questionCount"].intValue
                    break
                default:
                    break
                }
            }
            DataManager.instance.disciplinesDictionary[discipline["disciplineId"].intValue] = disciplineItem
        }
        
        transformDisciplineDictionaryIntoArray()
        
        return disciplinesArray
    }
    
    static func transformDisciplineDictionaryIntoArray() {
        disciplinesArray.removeAll()
        
        for (_, discipline) in DataManager.instance.disciplinesDictionary {
            disciplinesArray.append(discipline)
        }
    }
    
    // MARK: - Leaderboard Users
    
    static var leaderboardUsersArray: [LeaderboardUser] = []
    
    static func parseLeaderboardUsersList(leaderboardUsers: [AnyObject]) -> [LeaderboardUser] {
        
        leaderboardUsersArray.removeAll()
        
        for leaderboardUserJson in leaderboardUsers {
            let leaderboardUser = JSON(leaderboardUserJson)
            print("[ParseUtils] leaderboardUser: \(leaderboardUser)")
            
            let leaderboardUserItem: LeaderboardUser = LeaderboardUser(id: leaderboardUser["id"].intValue, name: leaderboardUser["name"].stringValue, email: leaderboardUser["email"].stringValue, rank: leaderboardUser["rank"].intValue, score: leaderboardUser["score"].floatValue, iconUrl: leaderboardUser["icon"].stringValue)
            
            leaderboardUsersArray.append(leaderboardUserItem)
        }
        
        return leaderboardUsersArray
    }
}
