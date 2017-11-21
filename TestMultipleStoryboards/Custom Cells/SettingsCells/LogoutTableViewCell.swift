//
//  LogoutTableViewCell.swift
//  TestMultipleStoryboards
//
//  Created by Richard on 11/3/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit
import FirebaseAuth

class LogoutTableViewCell: UITableViewCell {
    
    @IBOutlet weak var logout: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func LogoutBtn(_ sender: Any) {
        // setup delegate and call logout segue from the settings table view controller
        //self.performSegue(withIdentifier: "logoutSegue", sender: AnyObject?.self)
    }
}

