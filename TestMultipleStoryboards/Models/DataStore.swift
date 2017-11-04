//
//  DataStore.swift
//  TestMultipleStoryboards
//
//  Created by Liu, Robert J on 10/28/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//  Really a handler for operations on the database, bad naming
//

import Foundation
import Firebase

class DataStore {
    
    static let shared = DataStore()
    private var ref: DatabaseReference!
    private var currUser: User!
    private var events: [Event]!
    
    private init() {
        ref = Database.database().reference()
    }
    
    func getUser() -> User {
        return self.currUser
    }
    
    func setUser(user: User) {
        currUser = user
    }
    
    // Load all the events from firebase
    func loadEvents() {
        events = [Event]()
        
        // Fetch the data from Firebase and store it in our internal people array.
        // This is a one-time listener.
        ref.child("events").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get the top-level dictionary.
            let value = snapshot.value as? NSDictionary
            if let events = value {
                // Iterate over the person objects and store in our internal people array.
                for i in events {
                    let title = i.key as! String
                    let event = i.value as! [String:String]
                    let description = event["event description"]
                    let type = event["event type"]
                    let newEvent = Event(title: title, description: description!, type: type!)
                    self.events.append(newEvent)
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    // Encode emails since firebase cannot handle them
    func encodeKey(s: String) -> String {
        var newstring = s.replacingOccurrences(of: ".", with: "%")
        newstring = newstring.replacingOccurrences(of: "@", with: "%2E")
        return newstring
    }
    
    // Gets an event based on the id
    func getEvent(int: Int) -> Event {
        return events![int]
    }
}
 
