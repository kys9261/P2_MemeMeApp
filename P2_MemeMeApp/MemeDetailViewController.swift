//
//  MemeDetailViewController.swift
//  P2_MemeMeApp
//
//  Created by KimCP on 2015. 6. 2..
//  Copyright (c) 2015년 BeehiveStudio. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    var index: memeObject?
    
    @IBOutlet var imageView: UIImageView!

    override func viewDidLoad() {
        imageView.image = index?.memeImg
    }
}
