//
//  ModifiedKolodaView.swift
//  TestMultipleStoryboards
//
//  Created by Robert on 10/30/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit
import Koloda

class ModifiedKolodaView: UIView {

    var labelText: String?
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.text = labelText
    }
}
