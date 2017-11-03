//
//  CustomOverlayView.swift
//  TestMultipleStoryboards
//
//  Created by Robert on 10/30/17.
//  Copyright © 2017 Summer Moon Solutions. All rights reserved.
//

import UIKit

import UIKit
import Koloda

private let overlayRightImageName = "yesOverlayImage"
private let overlayLeftImageName = "noOverlayImage"

class CustomOverlayView: OverlayView {
    
    @IBOutlet lazy var overlayImageView: UIImageView! = {
        [unowned self] in
        
        var imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)
        
        return imageView
        }()
    
    override var overlayState: SwipeResultDirection? {
        didSet {
            switch overlayState {
            case .left? :
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .right? :
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
        }
    }
    
}
