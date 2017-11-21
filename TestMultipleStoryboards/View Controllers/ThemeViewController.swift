//
//  ThemeViewController.swift
//  TestMultipleStoryboards
//
//  Created by xjosuex7 on 11/14/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit

class ThemeViewController: UIViewController {

    @IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var applyLabelButton: UIButton!
    @IBOutlet weak var cancelLabelButton: UIButton!
    
    var theme = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = theme + " Theme"
        self.navigationItem.hidesBackButton = true
        
        applyLabelButton.setTitleColor(Style.buttonTextColor, for: .normal)
        applyLabelButton.backgroundColor = Style.buttonBackgroundColor
        cancelLabelButton.setTitleColor(Style.buttonTextColor, for: .normal)
        cancelLabelButton.backgroundColor = Style.buttonBackgroundColor
        themeLabel.text = theme
        
        if theme == Style.availableThemes[0] {
            themeLabel.textColor = UIColor.white
            themeLabel.backgroundColor = UIColor(red: 249/255, green: 174/255, blue: 82/255, alpha: 1.0)
        }
        else if theme == Style.availableThemes[1]{
            themeLabel.textColor = UIColor(red: 249/255, green: 174/255, blue: 82/255, alpha: 1.0)
            themeLabel.backgroundColor = UIColor.darkGray
        }
        else {
            themeLabel.textColor = UIColor(red: 249/255, green: 174/255, blue: 82/255, alpha: 1.0)
            themeLabel.backgroundColor = UIColor.white
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.view.backgroundColor = Style.backgroundColor
        self.navigationController?.navigationBar.barTintColor = Style.barTintColor
        self.navigationController?.navigationBar.tintColor = Style.textColor
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : Style.textColor]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func applyButton(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(theme, forKey: "Theme")
        Style.loadTheme()
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

}
