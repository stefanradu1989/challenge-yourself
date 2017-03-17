//
//  CompetitionTableViewController.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 08/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

protocol CompetitionTitleDelegate: class {
    func getTitle(for controller: UIViewController) -> String
    
}

class CompetitionController: UIViewController, UITableViewDelegate, UITableViewDataSource, DatamanagerListener, CompetitionTitleDelegate, CompetitionCellDelegate {
 
    @IBOutlet weak var startCompetitionButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    struct DisciplineSelection {
        var easy: Bool
        var medium: Bool
        var hard: Bool
    }
    
    var difficultySelection: [DisciplineSelection] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        DataManager.instance.addListener(listener: self)
        NetworkAssistant.instance.getDisciplines()
        
        startCompetitionButton.isEnabled = false
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

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return DataManager.instance.disciplineCount
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompetitionCell", for: indexPath) as! CompetitionCell
        
        // Configure the cell...
        let discipline = DataManager.instance.disciplineList[indexPath.row]
        let disciplineColor = ColorUtils.hexStringToUIColor(hex: discipline.color)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.titleLabel.textColor = disciplineColor
        cell.titleLabel.text = discipline.name
        cell.titleImage.image = DataManager.instance.getDisciplineIcon(id: discipline.id, imageUrl: discipline.iconUrl)
        
        cell.delegate = self
        
        cell.setButtonsTextColor(color: disciplineColor)
        cell.setButtonsBackgroundColor(color: disciplineColor)
        
        let selectedDifficulties: DisciplineSelection = difficultySelection[indexPath.row]
        
        cell.setEasyButtonValue(selected: selectedDifficulties.easy)
        cell.setMediumButtonValue(selected: selectedDifficulties.medium)
        cell.setHardButtonValue(selected: selectedDifficulties.hard)
        
        return cell
    }
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Send Data
    
    var lastClickedCell = 0
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did tap at \(indexPath.section), \(indexPath.row)")
        
        lastClickedCell = indexPath.row
    }
    
    func getTitle(for controller: UIViewController) -> String {
        return "\(lastClickedCell)"
    }
    
    // MARK: - CompetitionCellDelegate
    
    func cellDidUpdateDifficultySelection(cell: CompetitionCell, difficulty: String, selected: Bool) {
        let cellIndex = tableView.indexPath(for: cell)
        switch difficulty {
        case "easy":
            difficultySelection[cellIndex!.row].easy = selected
        case "medium":
            difficultySelection[cellIndex!.row].medium = selected
        case "hard":
            difficultySelection[cellIndex!.row].hard = selected
        default:
            print("Difficulty not received")
        }
        updateStartButtonState()
    }
    
    func updateStartButtonState() {
        let enableButton = difficultySelection.reduce(false) { (result, item) -> Bool in
            return result || item.easy || item.medium || item.hard
        }
        
        startCompetitionButton.isEnabled = enableButton
    }
    
    // MARK: - Send data to AnswerQuestionController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let navController = segue.destination as? UINavigationController {
            if let answerQuestionController = navController.topViewController as? AnswerQuestionController {
                answerQuestionController.selectData = createSelectionData()
            }
        }
    }
    
    func createSelectionData() -> [Dictionary<String , String>] {
        var easySelection : [Int] = []
        var mediumSelection : [Int] = []
        var hardSelection : [Int] = []
        var disciplineId: Int = 1
        
        var easyDictionary : Dictionary<String , String> = [String : String]()
        var mediumDictionary : Dictionary<String , String> = [String : String]()
        var hardDictionary : Dictionary<String , String> = [String : String]()
        
        var selectData : [Dictionary<String , String>] = []
        
        for selection in difficultySelection {
            if selection.easy {
                easySelection.append(disciplineId)
            }
            if selection.medium {
                mediumSelection.append(disciplineId)
            }
            if selection.hard {
                hardSelection.append(disciplineId)
            }
            disciplineId += 1
        }
        
        if !easySelection.isEmpty {
            easyDictionary["difficulty"] = "easy"
            easyDictionary["disciplineIdList"] = ParseUtils.transformIntArrayToString(array: easySelection, element: ",")
            selectData.append(easyDictionary)
        }
        if !mediumSelection.isEmpty {
            mediumDictionary["difficulty"] = "medium"
            mediumDictionary["disciplineIdList"] = ParseUtils.transformIntArrayToString(array: mediumSelection, element: ",")
            selectData.append(mediumDictionary)
        }
        if !hardSelection.isEmpty {
            hardDictionary["difficulty"] = "hard"
            hardDictionary["disciplineIdList"] = ParseUtils.transformIntArrayToString(array: hardSelection, element: ",")
            selectData.append(hardDictionary)
        }
        
        return selectData
    }
    
    // MARK: - DataManagerListener
    
    func didReceiveDisciplines() {
        difficultySelection = []
        for _ in DataManager.instance.disciplineList {
            difficultySelection.append(DisciplineSelection(easy: false, medium: false, hard: false))
        }
        tableView.reloadData()
    }
    
    func didLoadDisciplineIcon(disciplineId: Int) {
        print("[CompetitionController] didLoadDisciplineIcon for id: \(disciplineId)")
        let disciplinesArray = DataManager.instance.disciplineList
        for (index, item) in disciplinesArray.enumerated() {
            if disciplineId == item.id {
                let indexPaths = tableView.indexPathsForVisibleRows
                for ip in indexPaths! {
                    if ip.row == index {
                        tableView.reloadRows(at: [ip], with: .automatic)
                        return
                    }
                }
            }
        }
    }
}
