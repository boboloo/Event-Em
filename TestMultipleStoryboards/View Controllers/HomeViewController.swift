//
//  HomeViewController.swift
//  TestMultipleStoryboards
//
//  Created by Robert on 10/27/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit
import Koloda

class HomeViewController: UIViewController {

    @IBOutlet weak var NoButton: UIButton!
    @IBOutlet weak var CheckButton: UIButton!
    @IBOutlet weak var kolodaView: KolodaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup swiping
        kolodaView.dataSource = self
        kolodaView.delegate = self
        
        // setup settings navigation
        self.navigationItem.hidesBackButton = true
        let settingImg = resizeImage(image: UIImage(named: "settings")!, targetSize: CGSize(width: 30.0, height: 30.0))
        let settingBtn = UIButton(type: .custom)
        settingBtn.setImage(settingImg, for: .normal)
        settingBtn.addTarget(self, action: #selector(pushToNextVC), for: .touchUpInside)
        let barBtn = UIBarButtonItem(customView: settingBtn)
        self.navigationItem.rightBarButtonItem = barBtn
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !DataStore.shared.onDetail {
            self.kolodaView.resetCurrentCardIndex()
            self.kolodaView.reloadData()
        }
        else {
            DataStore.shared.onDetail = false
        }
        DataStore.shared.getLikedEvents()
        self.view.backgroundColor = Style.backgroundColor
        self.navigationController?.navigationBar.barTintColor = Style.barTintColor
        self.navigationController?.navigationBar.tintColor = Style.textColor
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : Style.textColor]
        self.kolodaView.backgroundColor = Style.backgroundColor

    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func pushToNextVC() {
        let settings = self.storyboard?.instantiateViewController(withIdentifier: "SettingsTVC") as? SettingsTableViewController
        self.navigationController?.pushViewController(settings!, animated:
            true)
        DataStore.shared.onDetail = true
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
        DataStore.shared.onDetail = true
        let event = DataStore.shared.getEvent(int: index)
        vc.ET = event.title
        vc.ED = event.description
        vc.ETT = event.type
 
        let nc = UINavigationController(rootViewController: vc)
        // Show it to the user.
        present(nc, animated: true, completion: nil)
    }
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == SwipeResultDirection.left {
            DataStore.shared.saveSwipe(index: index, liked: false)
        }
        else {
            DataStore.shared.saveSwipe(index: index, liked: true)
        }
    }
}

// Modifies how cards are displayed with the view controller
extension HomeViewController: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return DataStore.shared.eventCount()
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .moderate
    }

    // INDEX PROBLEM
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let newView = (Bundle.main.loadNibNamed("ModifiedKolodaView", owner: self, options: nil)![0] as? ModifiedKolodaView)!
        
        let event = DataStore.shared.getEvent(int: index)
        let title = event.title
        let url = event.imageURL
        let image = DataStore.shared.getImage(title: url)
        
        newView.image.contentMode = .scaleAspectFit
        newView.image.image = image
        newView.label.text = title
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
