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
    
    func login(email: String, password: String) -> Bool {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
        }
        let user = Auth.auth().currentUser
        if user == nil {
            return false
        }
        return true
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch {
            print("already logged out")
        }
    }
    
    func getUser() -> User {
        return self.currUser
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
    
    // Gets an event based on the id
    func getEvent(int: Int) -> Event {
        return events![int]
    }
}
 
