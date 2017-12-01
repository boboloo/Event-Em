//
//  SettingsTableViewController.swift
//  TestMultipleStoryboards
//
//  Created by Robert Liu on 10/31/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit                                                                                                                                                                                                           

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Settings"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        for i in DataStore.shared.likedEvents {
            print(i.title)
        }
        self.view.backgroundColor = Style.backgroundColor
        self.navigationController?.navigationBar.barTintColor = Style.barTintColor
        self.navigationController?.navigationBar.tintColor = Style.textColor
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : Style.textColor]
        self.tableView.reloadData()

    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = Style.backgroundColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileTableViewCell
            cell.selectionStyle = .none
            cell.profileName.text = DataStore.shared.getUser().email
            cell.profileName.textColor = Style.textColor
            self.tableView.rowHeight = 130
            cell.profileImage.image = DataStore.shared.profileImage
            
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myEventsCell", for: indexPath) as! MyEventsTableViewCell
            cell.myEvents.textColor = Style.textColor
            self.tableView.rowHeight = 50
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "eventHistoryCell", for: indexPath) as! EventHistoryTableViewCell
            cell.eventHistory.textColor = Style.textColor
            self.tableView.rowHeight = 50
            return cell
        }
        else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TouchIDCell", for: indexPath) as! TouchIDTableViewCell
            cell.touchID.textColor = Style.textColor
            self.tableView.rowHeight = 50
            return cell
        }
        else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "toggleEventsCell", for: indexPath) as! ToggleEventsTableViewCell
            cell.toggleEvents.textColor = Style.textColor
            self.tableView.rowHeight = 50
            return cell
        }
        else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myThemesCell", for: indexPath) as! MyThemesTableViewCell
            cell.myThemes.textColor = Style.textColor
            self.tableView.rowHeight = 50
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "logoutCell", for: indexPath) as! LogoutTableViewCell
            cell.logout.textColor = Style.textColor
            self.tableView.rowHeight = 50
            return cell
        }
    }
    
}
