//
//  DataManager.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 20/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

@objc
protocol DatamanagerListener:class {
    @objc optional func didReceiveUserDetails()
    
    @objc optional func didReceiveDisciplines()
    
    @objc optional func didLoadDisciplineIcon(disciplineId: Int)
    
    @objc optional func didReceiveLeaderboardUsers()
    
    @objc optional func didLoadLeaderboardUserIcon(leaderboardUserId: Int)
    
    @objc optional func didReceiveQuestion()
}

class DataManager {
    
    static let instance = DataManager()
    private init() {}
    
    // MARK: - Listeners
    
    private var listeners: [DatamanagerListener] = []
    
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
    
    // MARK: - User Details
    
    private var user: UserDetails? = nil
    
    func insertUser(userResponse: Dictionary<String, Any>) {
        user = ParseUtils.parseUserDetails(userDetailsJson: userResponse)
        
        for i in (0..<listeners.count) {
            listeners[i].didReceiveUserDetails?()
        }
    }
    
    func getCurrentUser() -> UserDetails {
        return user!
    }
    
    // MARK: - Discipline
    
    var disciplineList: [Discipline] = []
    var disciplineCount: Int = 0
    var disciplinesDictionary: Dictionary<Int, Discipline> = [Int: Discipline]()
    
    func insertDisciplines(disciplines: [AnyObject]) {
        disciplineList = ParseUtils.parseDisciplinesList(disciplines: disciplines)
        disciplineCount = disciplineList.count
        
        for i in (0..<listeners.count) {
            listeners[i].didReceiveDisciplines?()
        }
    }
    
    func getDisciplineIcon(id: Int, imageUrl: String) -> UIImage? {
        let disciplineIcon = CacheManager.instance.getDiciplineIcon(id: id)
        if disciplineIcon != nil {
            return disciplineIcon
        }
        NetworkAssistant.instance.getPhoto(imageurl: imageUrl){
            responseObject, error in
            if responseObject != nil {
                CacheManager.instance.insertDisciplineIcon(id: id, image: responseObject!)
                
                for i in (0..<self.listeners.count) {
                    self.listeners[i].didLoadDisciplineIcon?(disciplineId: id)
                }
                
                print("Image saved in cache")
            } else {
                print("responseObject is nil \n error: \(error.debugDescription)")
            }
        }
        return nil
    }
    
    func getDisciplineColor(id: Int) -> String {
        var color: String = ""
        for item in disciplineList {
            if item.id == id{
                color = item.color
            }
        }
        return color
    }
    
    // MARK: - Leaderboard Users
    
    var leaderboardUsersList: [LeaderboardUser] = []
    var leaderboardUsersCount = 0
    
    func insertLeaderboardUsers(leaderboardUsers: [AnyObject]) {
        leaderboardUsersList = ParseUtils.parseLeaderboardUsersList(leaderboardUsers: leaderboardUsers)
        leaderboardUsersCount = leaderboardUsersList.count
        
        for i in (0..<listeners.count) {
            listeners[i].didReceiveLeaderboardUsers?()
        }
    }
    
    func getLeaderboardUser(id: Int) -> LeaderboardUser {
        var currentUser: LeaderboardUser? = nil
        
        for user in leaderboardUsersList {
            if user.id == id {
                currentUser = user
            }
        }
        return currentUser!
    }
    
    func getLeaderboardUserIcon(id: Int, imageUrl: String) -> UIImage? {
        let leaderboardUserIcon = CacheManager.instance.getLeaderboardUserIcon(id: id)
        if leaderboardUserIcon != nil {
            return leaderboardUserIcon
        }
        NetworkAssistant.instance.getPhoto(imageurl: imageUrl){
            responseObject, error in
            if responseObject != nil {
                CacheManager.instance.insertleaderboardUserIcon(id: id, image: responseObject!)
                for i in (0..<self.listeners.count) {
                    self.listeners[i].didLoadLeaderboardUserIcon?(leaderboardUserId: id)
                }
                print("Image saved in cache")
            } else {
                print("responseObject is nil \n error: \(error.debugDescription)")
            }
        }
        return nil
    }
    
    // MARK: - Question
    
    var currentQuestion: Question? = nil
    
    func insertNewQuestion(questionResponse: [String : Any]) {
        currentQuestion = ParseUtils.parseQuestion(questionResponse: questionResponse)
        
        for i in (0..<listeners.count) {
            listeners[i].didReceiveQuestion?()
        }
    }
    
    func getQuestion() -> Question? {
        return currentQuestion
    }
    
    func getAnswersCount() -> Int {
        if currentQuestion != nil {
            return currentQuestion!.answers.count
        } else {
            return 0
        }
    }
}
