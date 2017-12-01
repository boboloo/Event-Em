//
//  ToggleEventsTableViewController.swift
//  TestMultipleStoryboards
//
//  Created by xjosuex7 on 11/16/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit

class ToggleEventsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Toggle Events"
        let settingImg = resizeImage(image: UIImage(named: "settings")!, targetSize: CGSize(width: 30.0, height: 30.0))
        let settingBtn = UIButton(type: .custom)
        settingBtn.setImage(settingImg, for: .normal)
        settingBtn.addTarget(self, action: #selector(popToPreviousVC), for: .touchUpInside)
        let barBtn = UIBarButtonItem(customView: settingBtn)
        self.navigationItem.leftBarButtonItem = barBtn
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.barTintColor = Style.barTintColor
        self.navigationController?.navigationBar.tintColor = Style.textColor
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : Style.textColor]
        self.view.backgroundColor = Style.backgroundColor
        self.tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = Style.backgroundColor
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
    
    func popToPreviousVC(){
        _ = navigationController?.popViewController(animated: true)
        DataStore.shared.loadEvents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EventTypes.shared.count()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toggleCell", for: indexPath) as! ToggleTableViewCell

        // Configure the cell...
        let category = EventTypes.shared.getEventType(index: indexPath.row)
        
        cell.eventCategory.text = category.name
        cell.eventCategory.textColor = Style.textColor
        cell.toggleSwitch.isOn = category.toggled!
        cell.toggleSwitch.tag = indexPath.row
        cell.selectionStyle = .none
        
        return cell
    }
    
    @IBAction func toggleClicked(_ sender: Any) {
        let toggle = sender as! UISwitch
        let index = toggle.tag
        let category = EventTypes.shared.getEventType(index: index)
        category.changeToggle()
        DataStore.shared.onDetail = false
    }

}
