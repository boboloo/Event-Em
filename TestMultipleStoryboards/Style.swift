//
//  Style.swift
//  TestMultipleStoryboards
//
//  Created by xjosuex7 on 11/14/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
// Site to pick the Colors https://www.ralfebert.de/snippets/ios/swift-uicolor-picker/
//

import Foundation
import UIKit

struct Style{
    
    static var font = UIFont(name: "Helvetica-Bold", size: 20)
    static var textColor = UIColor.white
    static var backgroundColor = UIColor(red: 249/255, green: 174/255, blue: 82/255, alpha: 1.0)
    static var buttonTextColor = UIColor(red: 249/255, green: 175/255, blue: 84/255, alpha: 1.0)
    static var buttonBackgroundColor = UIColor.white
    static var backgroundColorHighlighted = UIColor.lightGray
    static var barTintColor = UIColor(red: 249/255, green: 212/255, blue: 167/255, alpha: 1.0)
    
    static func themeOrange(){
        // MARK: ToDo Table Section Headers
        font = UIFont(name: "Helvetica", size: 18)
        textColor = UIColor.white
        backgroundColor = UIColor(red: 249/255, green: 174/255, blue: 82/255, alpha: 1.0)
        buttonTextColor = UIColor(red: 249/255, green: 175/255, blue: 84/255, alpha: 1.0)
        buttonBackgroundColor = UIColor.white
        backgroundColorHighlighted = UIColor.lightGray
        barTintColor = UIColor(red: 249/255, green: 212/255, blue: 167/255, alpha: 1.0)
    }
    static func themeGray(){
        font = UIFont(name: "Helvetica", size: 18)
        textColor = UIColor(red: 249/255, green: 174/255, blue: 82/255, alpha: 1.0)
        backgroundColor = UIColor.darkGray
        buttonTextColor = UIColor.white
        buttonBackgroundColor = UIColor(red: 249/255, green: 174/255, blue: 82/255, alpha: 1.0)
        backgroundColorHighlighted = UIColor.lightGray
        barTintColor = UIColor.lightGray
    }
    static func themeWhite(){
        font = UIFont(name: "Helvetica", size: 18)
        textColor = UIColor(red: 249/255, green: 174/255, blue: 82/255, alpha: 1.0)
        backgroundColor = UIColor.white
        buttonTextColor = UIColor.black
        buttonBackgroundColor = UIColor(red: 249/255, green: 174/255, blue: 82/255, alpha: 1.0)
        backgroundColorHighlighted = UIColor.lightGray
        barTintColor = UIColor.lightGray
    }
    
    static let availableThemes = ["Orange", "Gray", "White"]
    
    static func loadTheme(){
        let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: "Theme"){
            // Select the Theme
            if name == "Orange" { themeOrange() }
            else if name == "Gray" { themeGray() }
            else { themeWhite() }
        }else{
            defaults.set("Orange", forKey: "Theme")
            themeOrange()
        }
    }
    
}
