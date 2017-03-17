//
//  AnswerQuestionController.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 09/03/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

class AnswerQuestionController: UIViewController, UITableViewDelegate, UITableViewDataSource, DatamanagerListener { //, AnswerCellDelegate
    
    @IBOutlet weak var disciplineLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bottomButtonsView: UIView!
    @IBOutlet weak var solutionButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nextQuestionButton: UIButton!
    
    var selectData : [Dictionary<String , String>] = [[String : String]()]
    var question: Question? = nil
    var selectedAnswerId: Int = 0
    var bottomButtonsViewWidth: CGFloat = 0
    var bottomButtonsViewHeight: CGFloat = 0
    

    @IBAction func closeAnswerQuestionScreen(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitQuestionAnswer(_ sender: Any) {
        solutionButton.isHidden = false
        submitButton.isHidden = true
        nextQuestionButton.isHidden = false
        
        solutionButton.frame.size.width = bottomButtonsViewWidth / 3
        submitButton.frame.size.width = 0
        nextQuestionButton.frame.size.width = bottomButtonsViewWidth / 3
        
        print("[AnswerQuestionController] selectedAnswerId: \(selectedAnswerId)")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        NetworkAssistant.instance.requestQuestion(userId: DataManager.instance.getCurrentUser().id, select: selectData)
        solutionButton.isHidden = true
        nextQuestionButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bottomButtonsViewWidth = bottomButtonsView.bounds.width
        bottomButtonsViewHeight = bottomButtonsView.bounds.height
        
        solutionButton.frame.size.width = 0
        submitButton.frame.size.width = bottomButtonsViewWidth / 3
        nextQuestionButton.frame.size.width = 0
        
        DataManager.instance.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DataManager.instance.removeListener(listener: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.getAnswersCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerCell
        
//        cell.delegate = self
        
        cell.answerLabel.text = question?.answers[indexPath.row].body

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as! AnswerCell
        selectedAnswerId = (question?.answers[indexPath.row].id)!
        print("[AnswerQuestionController] selectedAnswerId on cell click: \((question?.answers[indexPath.row].id)!)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    /*
    // MARK: - AnswerCellDelegate
    
    func cellDidUpdateCurrentSelectedAnswer(cell: AnswerCell) {
        let cellIndex = tableView.indexPath(for: cell)
        selectedAnswerId = (question?.answers[cellIndex!.row].id)!
    }
    */
    // MARK: - DataManagerListener
    
    func didReceiveQuestion() {
        if DataManager.instance.getQuestion() != nil {
            question = DataManager.instance.getQuestion()
            updateUi()
        }
        tableView.reloadData()
    }
    
    // MARK: - Update UI
    
    func updateUi() {
        disciplineLabel.text = question!.disciplineName
        disciplineLabel.textColor = ColorUtils.hexStringToUIColor(hex: DataManager.instance.getDisciplineColor(id: question!.disciplineId))
        timeLabel.textColor = ColorUtils.hexStringToUIColor(hex: DataManager.instance.getDisciplineColor(id: question!.disciplineId))
        difficultyLabel.text = question!.difficulty
        questionLabel.text = question!.body
    }
}
