//
//  Discipline.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 20/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import Foundation

class Discipline {
    
    private var disciplineName: String
    private var disciplineIconUrl: String
    private var disciplineColor: String
    private var disciplineDifficulties: NSDictionary
    
    init(disciplineName: String, disciplineIconUrl: String, disciplineColor: String, disciplineDifficulties: NSDictionary) {
        self.disciplineName = disciplineName
        self.disciplineIconUrl = disciplineIconUrl
        self.disciplineColor = disciplineColor
        self.disciplineDifficulties = disciplineDifficulties
    }
}
