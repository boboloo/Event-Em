//
//  Event.swift
//  TestMultipleStoryboards
//
//  Created by Robert on 10/29/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import Foundation

class Event {
    
    var title: String
    var description: String
    var type: String
    var imageURL: String
    
    init(title: String, description: String, type: String, imageURL: String){
        self.title = title
        self.description = description
        self.type = type
        self.imageURL = imageURL
    }
    
}
