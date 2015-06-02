//
//  SentMemesCollectionView.swift
//  P2_MemeMeApp
//
//  Created by KimCP on 2015. 6. 1..
//  Copyright (c) 2015년 BeehiveStudio. All rights reserved.
//

import Foundation
import UIKit

class SentMemesCollectionView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet var memeCollectionView: UICollectionView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        memeCollectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        let memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        let meme = memes[indexPath.row]
        cell.imageView.image = meme.memeImg
        return cell
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let object:AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("detailMeme")!
        let detailVC = object as! MemeDetailViewController
        let memes = (UIApplication.sharedApplication().delegate as! AppDelegate).memes
        detailVC.index = memes[indexPath.row]
        self.navigationController!.pushViewController(detailVC, animated: true)
    }
}