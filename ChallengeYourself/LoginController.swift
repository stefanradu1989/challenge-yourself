//
//  ViewController.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 06/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginController: UIViewController {
    
    @IBOutlet weak var emailLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
    @IBOutlet weak var progressView: UIActivityIndicatorView!
    
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        progressView.hidesWhenStopped = true
        
        progressView.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func makeLogin(_ sender: UIButton) {
        progressView.startAnimating()
        loginButton.isHidden = true
        
        NetworkAssistant.instance.login(email: emailLabel.text!, password: passwordLabel.text!) {
            responseObject, error in
            if responseObject != nil {
                let json = JSON(responseObject!)
                
                print("JSON: \(json)")
                
                let message = json["message"].stringValue
                
                if message.contains("wrong") {
                    print("Message: \(message)")
                } else {
                    let id = json["message"].intValue
                    
                    Session.instance.userId = id
                    Session.instance.userEmail = self.emailLabel.text
                    
                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main);
                    let homeController = storyboard.instantiateViewController(withIdentifier: "HomeController")
                    self.present(homeController, animated: true, completion: nil)
                }
                self.progressView.stopAnimating()
                self.loginButton.isHidden = false
            } else {
                print("responseObject is nil")
                self.progressView.stopAnimating()
                self.loginButton.isHidden = false
            }
        }

    }
}

