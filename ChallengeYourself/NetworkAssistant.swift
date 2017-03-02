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

class NetworkAssistant {
    
    static let instance = NetworkAssistant()
    private init() {}
    
    private let base_url = "https://challenge-yourself-carparked.c9users.io"
    private let login_path = "/users/login"
    
    
    func login(email: String, password: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()){
        loginCall(email: email, password: password, completionHandler: completionHandler)
    }
    
    func loginCall(email: String, password: String, completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
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
    
    private let discipline_path = "/discipline/getPrerequisites"
    
    func getDisciplines() { //completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        disciplinesCall()//completionHandler: completionHandler)
    }
    
    func disciplinesCall() {//completionHandler: @escaping (NSDictionary?, Error?) -> ()) {
        let disciplines_url = NetworkAssistant.instance.base_url + NetworkAssistant.instance.discipline_path
        
        Alamofire.request(disciplines_url).responseJSON { response in
            switch response.result {
            case .success(let value):
                DataManager.instance.insertDisciplines(disciplines: value as! [AnyObject])
                //completionHandler(value as? NSDictionary, nil)
            case .failure(let error):
                print("Error while making disciplines request \n Error: \(error.localizedDescription)")
                //completionHandler(nil, error)
            }
        }
    }
    
//    func getPhoto(imageurl: String) {
//        Alamofire.request(imageurl).responseImage(completionHandler: <#T##(DataResponse<Image>) -> Void#>)
//    }
}

