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
    
    static var disciplinesArray: [Discipline] = []
    static var disciplinesDictionary: Dictionary<Int, Discipline> = [Int: Discipline]()
    
    static func parseDisciplinesList(disciplines: [AnyObject]) -> [Discipline] {
        
        for disciplineJson in disciplines {
            let discipline = JSON(disciplineJson)
            print("[ParseUtils] discipline: \(discipline)")
            
            var disciplineItem: Discipline
            
            if disciplinesDictionary[discipline["disciplineId"].intValue] == nil {
                
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
                disciplineItem = disciplinesDictionary[discipline["disciplineId"].intValue]!
                
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
            disciplinesDictionary[discipline["disciplineId"].intValue] = disciplineItem
        }
        
        transformDictionaryIntoArray()
        
        return disciplinesArray
    }
    
    static func transformDictionaryIntoArray() {
        for (_, discipline) in disciplinesDictionary {
            disciplinesArray.append(discipline)
        }
    }
}
