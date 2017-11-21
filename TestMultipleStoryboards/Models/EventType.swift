//
//  EventType.swift
//  TestMultipleStoryboards
//
//  Created by Richard on 11/18/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import Foundation

class EventType {
    
    var name: String?
    var toggled: Bool?
    
    init() {
    }
    
    init(name: String, toggled: Bool) {
        self.name = name
        self.toggled = toggled
    }
    
    func changeToggle() {
        if self.toggled! {
            self.toggled = false
        }
        else {
            self.toggled = true
        }
    }
}
