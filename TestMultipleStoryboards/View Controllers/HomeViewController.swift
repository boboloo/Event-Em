//
//  HomeViewController.swift
//  TestMultipleStoryboards
//
//  Created by Robert on 10/27/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit
import Koloda

private var numberOfCards: Int = 3

class HomeViewController: UIViewController {

    fileprivate var images: [UIImage] = {
        var array: [UIImage] = []
        for index in 0..<numberOfCards {
            array.append(UIImage(named: "Photo-\(index + 1)")!)
        }
        return array
    }()
    
    @IBOutlet weak var NoButton: UIButton!
    @IBOutlet weak var CheckButton: UIButton!
    @IBOutlet weak var kolodaView: KolodaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // setup
        self.navigationItem.hidesBackButton = true
        kolodaView.dataSource = self
        kolodaView.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(pushToNextVC))
    }
    
    func pushToNextVC() {
        let settings = self.storyboard?.instantiateViewController(withIdentifier: "SettingsTVC") as? SettingsTableViewController
        self.navigationController?.pushViewController(settings!, animated:
            true)
    }

    @IBAction func yesTapped(_ sender: Any) {
        kolodaView?.swipe(.right)
    }
    
    @IBAction func noTapped(_ sender: Any) {
        kolodaView?.swipe(.left)
    }
}

// Modifies cards interact with the view controller
extension HomeViewController: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        let storyboard = UIStoryboard(name: "EventDetail", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EventDetailVC") as! EventDetailViewController
        let event = DataStore.shared.getEvent(int: index)
        vc.ET = event.title
        vc.ED = event.description
        vc.EI = "Photo-\(index+1)"
        
        let nc = UINavigationController(rootViewController: vc)
        // Show it to the user.
        present(nc, animated: true, completion: nil)
    }
}

// Modifies how cards are displayed with the view controller
extension HomeViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return images.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let newView = (Bundle.main.loadNibNamed("ModifiedKolodaView", owner: self, options: nil)![0] as? ModifiedKolodaView)!
        newView.image.image = UIImage(named: "Photo-\(index+1)")
        newView.title!.text! = DataStore.shared.getEvent(int: index).title
        newView.layer.cornerRadius = 15
        newView.layer.masksToBounds = true
        return newView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        let overlay = Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? CustomOverlayView
        overlay!.layer.cornerRadius = 15
        overlay!.layer.masksToBounds = true
        return overlay
    }
}
