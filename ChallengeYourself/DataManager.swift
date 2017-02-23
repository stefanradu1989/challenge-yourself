//
//  DataManager.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 20/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import Foundation

protocol DatamanagerListener {
    func didReceiveDisciplines()
}

class DataManager {
    private var listeners: [DatamanagerListener] = []
    
    private var disciplineList: [Discipline] = []
    
    static let instance = DataManager()
    private init() {}
    
    func insertDisciplines(disciplines: [AnyObject]) {
        disciplineList = ParseUtils.parseDisciplinesList(disciplines: disciplines)
    }
    
    func addListener(listener: DatamanagerListener) {
        listeners.append(listener)
    }
    
    func removeListener(listener: DatamanagerListener) {
        var i = 0
        for item: DatamanagerListener in listeners {
            if (item === listener) {
               listeners.remove(at: i)
            }
            i += 1
        }
        
    }
}
