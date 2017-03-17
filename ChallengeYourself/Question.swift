//
//  Question.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 16/03/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import Foundation

class Question {
    
    var id: Int
    var title: String
    var body: String
    var correctAnswerId: Int
    var disciplineId: Int
    var disciplineIcon: String
    var disciplineName: String
    var difficulty: String
    var time: Int
    var solution: String
    var answers: [Answer]
    
    init(id: Int, title: String, body: String, correctAnswerId: Int, disciplineId: Int, disciplineIcon: String, disciplineName: String, difficulty: String, time: Int, solution: String, answers: [Answer]) {
        self.id = id
        self.title = title
        self.body = body
        self.correctAnswerId = correctAnswerId
        self.disciplineId = disciplineId
        self.disciplineIcon = disciplineIcon
        self.disciplineName = disciplineName
        self.difficulty = difficulty
        self.time = time
        self.solution = solution
        self.answers = answers
    }
}
