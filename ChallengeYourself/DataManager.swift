//
//  DataManager.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 20/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

protocol DatamanagerListener:class {
    func didReceiveDisciplines()
}

class DataManager {
    private var listeners: [DatamanagerListener] = []
    
    var disciplineList: [Discipline] = []
    var disciplineCount: Int = 0
//    var disciplineImages: Dictionary<Int, UIImage> = [Dictionary, UIImage]()
    
    static let instance = DataManager()
    private init() {}
    
    func insertDisciplines(disciplines: [AnyObject]) {
        disciplineList = ParseUtils.parseDisciplinesList(disciplines: disciplines)
        disciplineCount = disciplineList.count
        for i in (0..<listeners.count) {
            listeners[i].didReceiveDisciplines()
        }
    }
    
    func addListener(listener: DatamanagerListener) {
        listeners.append(listener)
    }
    
    func removeListener(listener: DatamanagerListener) {
        
        for i in 0..<listeners.count {
            if (listeners[i] === listener) {
                listeners.remove(at: i)
                break
            }
        }
    }
}
