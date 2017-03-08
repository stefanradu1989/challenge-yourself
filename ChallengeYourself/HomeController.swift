//
//  File.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 06/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var rankView: GradientView!
    @IBOutlet weak var scoreView: GradientView!
    @IBOutlet weak var correctAnswersView: GradientView!
    @IBOutlet weak var wrongAnswersView: GradientView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
}
