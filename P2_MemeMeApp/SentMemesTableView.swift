//
//  SentMemesTableView.swift
//  P2_MemeMeApp
//
//  Created by KimCP on 2015. 6. 1..
//  Copyright (c) 2015년 BeehiveStudio. All rights reserved.
//

import Foundation
import UIKit

class SentMemesTableView: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var memes: [memeObject]!
    @IBOutlet var memeTable: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        memeTable.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memeCell") as! UITableViewCell
        let meme = memes[indexPath.row]
        cell.imageView?.image = meme.memeImg
        cell.textLabel?.text = meme.topText! + meme.bottomText!
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("detailMeme")!
        let detailVC = object as! MemeDetailViewController
        detailVC.index = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailVC, animated: true)

    }
}