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
    
    // MARK: - User Details
    
    static func parseUserDetails(userDetailsJson: Dictionary<String, Any>) -> UserDetails {
        let userJson = JSON(userDetailsJson)
        
        print("[ParseUtils] user: \(userJson)")
        
        let userDetails: UserDetails = UserDetails(id: userJson["id"].intValue, name: userJson["name"].stringValue, email: userJson["email"].stringValue, rank: userJson["rank"].intValue, score: userJson["score"].floatValue, correctAnswers: userJson["correctAnswers"].intValue, wrongAnswers: userJson["wrongAnswers"].intValue)
        
        
        return userDetails
    }
    
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
        
        return disciplinesArray.sorted {$0.id < $1.id}
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
    
    // MARK: - Question
    
    static var question: Question? = nil
    
    static func parseQuestion(questionResponse: [String : Any]) -> Question? {
        var answers: [Answer] = []
        
        let questionJson = JSON(questionResponse)
        print("[ParseUtils] questionJson: \(questionJson)")
        
        for (_,answerJson):(String, JSON) in questionJson["answers"] {
            let id: Int = answerJson["id"].intValue
            let body: String = answerJson["body"].stringValue
            let answer = Answer(id:id, body: body)
            answers.append(answer)
        }
        
        question = Question(id: questionJson["id"].intValue, title: questionJson["title"].stringValue, body: questionJson["body"].stringValue, correctAnswerId: questionJson["correctAnswerId"].intValue, disciplineId: questionJson["disciplineId"].intValue, disciplineIcon: questionJson["disciplineIcon"].stringValue, disciplineName: questionJson["disciplineName"].stringValue, difficulty: questionJson["difficulty"].stringValue, time: questionJson["time"].intValue, solution: questionJson["solution"].stringValue, answers: answers)
        
        return question
    }
    
    // MARK: - get rank suffix
    
    static var ordinalSuffixes : [String]  = ["th", "st", "nd", "rd", "th", "th", "th", "th", "th", "th"]
    
    static func getOrdinalSuffix(count: Int) -> String {
        switch (count % 100) {
        case 11:
            return "th"
        case 12:
            return "th"
        case 13:
            return "th"
        default:
            return ordinalSuffixes[count % 10]
        }
    }
    
    // MARK: - Transformations
    
    // - Transform Int array to one String separated by element
    
    static func transformIntArrayToString(array: [Int], element: String) -> String {
        var string: String = ""
        var i = 1
        for item in array {
            if i < (array.count) {
                string += "\(item)" + element
            } else {
                string += "\(item)"
            }
            i += 1
        }
        return string
    }
    
    // - Transform something into JSON
    
    static func transformObjectIntoJson(obj: AnyObject) -> JSON {
        let json: JSON = JSON(obj)
        print("[ParseUtils]: json = \(json)")
        return json
    }
}
