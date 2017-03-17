//
//  NetworkAssistant.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 14/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//
import Alamofire
import AlamofireImage
import SwiftyJSON
import UIKit

class NetworkAssistant {
    
    static let instance = NetworkAssistant()
    private init() {}
    
    private let base_url = "https://challenge-yourself-carparked.c9users.io"
    
    // MARK: - Login
    
    private let login_path = "/users/login"
    
    
    func login(email: String, password: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()){
        loginCall(email: email, password: password, completionHandler: completionHandler)
    }
    
    private func loginCall(email: String, password: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        let login_url = NetworkAssistant.instance.base_url + NetworkAssistant.instance.login_path
        
        let loginParams: Parameters = [
            "email": email,
            "password": password
        ]
        
        Alamofire.request(login_url, method: .post, parameters: loginParams, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value as? NSDictionary, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
    
    // MARK: - Competition
    
    private let disciplines_path = "/discipline/getPrerequisites"
    
    func getDisciplines() {
        disciplinesCall()
    }
    
    private func disciplinesCall() {
        let disciplines_url = NetworkAssistant.instance.base_url + NetworkAssistant.instance.disciplines_path
        
        Alamofire.request(disciplines_url).responseJSON { response in
            switch response.result {
            case .success(let value):
                DataManager.instance.insertDisciplines(disciplines: value as! [AnyObject])
            case .failure(let error):
                print("Error while making disciplines request \n Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - User Details
    
    private let user_details_path = "/users/getDetails/"
    
    func getUserDetails(id: Int) {
        userDetailsCall(id: id)
    }
    
    private func userDetailsCall(id: Int) {
        let user_details_url = NetworkAssistant.instance.base_url + NetworkAssistant.instance.user_details_path + "\(id)"
        
        Alamofire.request(user_details_url).responseJSON { response in
            switch response.result {
            case .success(let value):
                DataManager.instance.insertUser(userResponse: value as! Dictionary)
            case .failure(let error):
                print("Error while making get user details request \n Error: \(error.localizedDescription)")
            }
        }
    }
        
    // MARK: - Photos
    
    func getPhoto(imageurl: String, completionHandler: @escaping (UIImage?, Error?) -> ()) {
        
        Alamofire.request(imageurl).responseImage { response in
            switch response.result{
            case .success(let value):
                completionHandler(value, nil)
            case .failure(let error):
                completionHandler(nil, error)
            }
        }
    }
        
    // MARK: - Leaderboard
    private let leaderboard_path = "/users/getAllUsers"
    
    func getLeaderboardUsers() {
        leaderboardUsersCall()
    }
    
    private func leaderboardUsersCall() {
        let leaderboard_url = NetworkAssistant.instance.base_url + NetworkAssistant.instance.leaderboard_path
        
        Alamofire.request(leaderboard_url).responseJSON { response in
            switch response.result {
            case .success(let value):
                DataManager.instance.insertLeaderboardUsers(leaderboardUsers: value as! [AnyObject])
            case .failure(let error):
                print("Error while making leaderboard users request \n Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Questions
    
    private let request_question_path = "/question/generateQuestion"
    
    
    func requestQuestion(userId: Int, select: [Dictionary<String , String>]){
        requestQuestionCall(userId: userId, select: select)
    }
    
    private func requestQuestionCall(userId: Int, select: [Dictionary<String , String>]) {
        let request_question_url = NetworkAssistant.instance.base_url + NetworkAssistant.instance.request_question_path
        
        let requestQuestionParams: Parameters = [
            "userId": userId,
            "select": select
        ]
        
        Alamofire.request(request_question_url, method: .post, parameters: requestQuestionParams, encoding: JSONEncoding.default, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    DataManager.instance.insertNewQuestion(questionResponse: value as! Dictionary)
                case .failure(let error):
                    print("Error while making request question call \n Error: \(error.localizedDescription)")
                }
        }
    }
}
