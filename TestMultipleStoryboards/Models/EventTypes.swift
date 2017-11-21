//
//  EventTypes.swift
//  TestMultipleStoryboards
//
//  Created by Richard on 11/18/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import Foundation

class EventTypes {
    
    static let shared = EventTypes()
    
    private init() {
        self.addEventType(name: "Campus & Community", toggled: true)
        self.addEventType(name: "Health & Wellness", toggled: true)
        self.addEventType(name: "Arts & Humanities", toggled: true)
    }
    
    private var eventTypes = [EventType]()
    
    func count() -> Int {
        return eventTypes.count
    }
    
    func addEventType(name: String, toggled: Bool) {
        eventTypes.append(EventType(name: name, toggled: toggled))
    }
    
    func getEventType(index: Int) -> EventType {
        guard index < eventTypes.count else { return EventType() }
        return eventTypes[index]
    }
}
