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
import FirebaseStorage

class DataStore {
    
    // database vars
    static let shared = DataStore()
    private var ref: DatabaseReference!
    
    // stuff for the current user
    private var currUser: User!
    private var events: [Event]!
    private var imageStorage = Storage.storage()
    private var images: [String: UIImage]! // stores dictionary of the images for events
    var profileImage: UIImage?
    
    // value to refresh the screen
    var onDetail: Bool = false
    
    private init() {
        ref = Database.database().reference()
    }
    
    func getUser() -> User {
        return self.currUser
    }
    
    func setUser(user: User) {
        currUser = user
    }
    
    func getProfilePic() {
        let gsReference = imageStorage.reference(forURL: "gs://event-em-68240.appspot.com/")
        
        let imageRef = gsReference.child("defaultperson.png")
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                // Data for imageURL is returned
                let image = UIImage(data: data!)
                self.profileImage = image!
            }
        }
    }
    
    // Load all the events from firebase
    func loadEvents() {

        events = [Event]()
        images = [String: UIImage]()
        	
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
                    let etype = event["event type"]
                    let imageURL = event["event photo"]
                    let newEvent = Event(title: title, description: description!, type: etype!, imageURL: imageURL!)
                    for i in 0 ..< EventTypes.shared.count() {
                        let eventType = EventTypes.shared.getEventType(index: i)
                        if eventType.name == newEvent.type {
                            if eventType.toggled! {
                                self.events.append(newEvent)
                                self.retrieveImage(title: title, imageURL: imageURL!)
                                
                            }
                        }
                    }
                }
            }
        })
        { (error) in
            print(error.localizedDescription)
        }
    }
    
    func retrieveImage(title: String, imageURL: String) {
        let gsReference = imageStorage.reference(forURL: "gs://event-em-68240.appspot.com/")

        let imageRef = gsReference.child(imageURL)
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(error)
            } else {
                // Data for imageURL is returned
                let image = UIImage(data: data!)
                self.images[title] = image
            }
        }
    }
    
    // Gets an event based on the id
    func getEvent(int: Int) -> Event {
        return events![int]
    }
    
    func eventCount() -> Int {
        return events.count
    }

    func getImage(title: String) -> UIImage {
        return images[title]!
    }
    
    func saveSwipe(index: Int, liked: Bool) {
        let key = self.ref.child("users").child(self.getUser().id!)
        key.child(DataStore.shared.getEvent(int: index).title).setValue(liked)
    }
}
 
