//
//  MemeTabBarController.swift
//  P2_MemeMeApp
//
//  Created by KimCP on 2015. 6. 1..
//  Copyright (c) 2015년 BeehiveStudio. All rights reserved.
//

import Foundation
import UIKit

class MemesTabBarController: UITabBarController {
    
    override func viewDidLoad() {
    
    }
    
    @IBAction func AddButtonClick(sender: UIBarButtonItem) {
    
       var controller: MemeEditViewController
        controller = self.storyboard?.instantiateViewControllerWithIdentifier("editMeme") as! MemeEditViewController
        presentViewController(controller, animated: true, completion: nil)
    }
}