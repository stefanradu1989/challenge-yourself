//
//  File.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 06/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

class HomeController: UIViewController, DatamanagerListener {
    
    
    @IBOutlet weak var wrongAnswersLabel: UILabel!
    @IBOutlet weak var correctAnswersLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var currentUserLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var rankView: GradientView!
    @IBOutlet weak var scoreView: GradientView!
    @IBOutlet weak var correctAnswersView: GradientView!
    @IBOutlet weak var wrongAnswersView: GradientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DataManager.instance.addListener(listener: self)
        NetworkAssistant.instance.getUserDetails(id: Session.instance.userId!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DataManager.instance.removeListener(listener: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        roundGradientViews()
    }
    
    func roundGradientViews() {
        
        rankView.layer.cornerRadius = rankView.bounds.width / 2
        scoreView.layer.cornerRadius = scoreView.bounds.width / 2
        correctAnswersView.layer.cornerRadius = correctAnswersView.bounds.width / 2
        wrongAnswersView.layer.cornerRadius = wrongAnswersView.bounds.width / 2
    }
    
    // MARK: - DataManagerListener
    
    func didReceiveUserDetails() {
        let currentUser = DataManager.instance.getCurrentUser()
        currentUserLabel.text = currentUser.name
        rankLabel.text = "Rank\n\n\(currentUser.rank)"
        scoreLabel.text = "Score\n\n\(currentUser.score)"
        correctAnswersLabel.text = "Correct Answers\n\n\(currentUser.correctAnswers)"
        wrongAnswersLabel.text = "Wrong Answers\n\n\(currentUser.wrongAnswers)"
    }
}
