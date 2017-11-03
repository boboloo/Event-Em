//
//  User.swift
//  TestMultipleStoryboards
//
//  Created by Liu, Robert J on 10/28/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import Foundation

class User {
    
    var id: String?
    var email: String?
    
    init() {
        id = ""
        email = ""
    }
    
    init(id: String, email: String) {
        self.id = id
        self.email = email
    }
    
}


