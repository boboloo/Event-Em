//
//  EventDetailViewController.swift
//  TestMultipleStoryboards
//
//  Created by Josue on 10/28/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var ET: String?
    var ED: String?
    var EI: String?
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup
        self.title = ET!
        eventImage.image = UIImage(named: EI!)
        eventImage.contentMode = .scaleAspectFit
        eventDescription!.text! = ED!
        eventDescription.sizeToFit()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

