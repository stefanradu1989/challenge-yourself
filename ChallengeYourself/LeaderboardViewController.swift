//
//  LeaderboardViewController.swift
//  ChallengeYourself
//
//  Created by Radu Stefan on 27/02/2017.
//  Copyright © 2017 Endava. All rights reserved.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DatamanagerListener {
    
    @IBOutlet weak var currentUserRank: UILabel!
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var currentUserScore: UILabel!
    @IBOutlet weak var currentUserPhoto: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DataManager.instance.addListener(listener: self)
        NetworkAssistant.instance.getLeaderboardUsers()
        
        let currentUser = DataManager.instance.getCurrentUser()
        let rankSuffix: String = ParseUtils.getOrdinalSuffix(count: currentUser.rank)
        currentUserName.text = currentUser.name
        currentUserRank.text = "\(currentUser.rank)\(rankSuffix)"
        currentUserScore.text = "\(currentUser.score)pts"
//        currentUserPhoto.image = DataManager.instance.getLeaderboardUserIcon(id: currentUser.id, imageUrl: DataManager.instance.getLeaderboardUser(id: currentUser.id).iconUrl)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DataManager.instance.removeListener(listener: self)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.leaderboardUsersCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath) as! LeaderboardCell
        
        // Configure the cell...
        let leaderboardUser = DataManager.instance.leaderboardUsersList[indexPath.row]
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.rankLabel.text = "\(leaderboardUser.rank)"
        cell.userNameLabel.text = leaderboardUser.name
        cell.userScoreLabel.text = "\(leaderboardUser.score)"
        cell.userPhoto.image = DataManager.instance.getLeaderboardUserIcon(id: leaderboardUser.id, imageUrl: leaderboardUser.iconUrl)
        
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - DataManagerListener
    
    func didReceiveLeaderboardUsers() {
        tableView.reloadData()
    }
    
    func didLoadLeaderboardUserIcon(leaderboardUserId: Int) {
        let leaderboardUsersArray = DataManager.instance.leaderboardUsersList
        for (index, item) in leaderboardUsersArray.enumerated() {
            if leaderboardUserId == item.id {
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
