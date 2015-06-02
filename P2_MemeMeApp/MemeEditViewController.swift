//
//  MemeEditViewController.swift
//  P2_MemeMeApp
//
//  Created by KimCP on 2015. 6. 1..
//  Copyright (c) 2015년 BeehiveStudio. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

class MemeEditViewController: UIViewController, UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate{

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var topTextField: UITextField!
    @IBOutlet var bottomTextField: UITextField!
    @IBOutlet var cameraButton: UIBarButtonItem!
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var navBar: UINavigationItem!

    @IBOutlet var shareButton: UIBarButtonItem!
    
    let imagePicker = UIImagePickerController()

    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -5.0
    ]
    
    override func viewDidLoad() {
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        
        //camera button enable
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        //textfield property
        self.topTextField.defaultTextAttributes = memeTextAttributes
        self.bottomTextField.defaultTextAttributes = memeTextAttributes

        self.topTextField.textAlignment = NSTextAlignment.Center
        self.bottomTextField.textAlignment = NSTextAlignment.Center
        
        self.shareButton.enabled = self.imageView.isFirstResponder()
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    //SoftKeyboard setting
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)

    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if self.bottomTextField.editing{
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    
    //UIButton Actions
    @IBAction func shareButtonClick(sender: UIBarButtonItem) {
        let image = UIImage()
        let controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        controller.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save(self.generateMemedImage())
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClick(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func cameraButtonClick(sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            //imagePicker.mediaTypes = [kUTTypeImage]
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func albumButtonClick(sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
    }
   
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in})
        imageView.image = image
        self.shareButton.enabled = true
    }
    
    func save(memedImage: UIImage) {
        var meme = memeObject(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImg: imageView.image, memeImg:memedImage)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage
    {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.toolBar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.setToolbarHidden(true, animated: false)
        self.toolBar.hidden = false

        return memedImage
    }
    
    //TextField Delegate
    func textFieldDidBeginEditing(textField: UITextField) {
        if self.topTextField.editing {
            self.topTextField.text = ""
        } else {
            self.bottomTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        topTextField.text = topTextField.text.uppercaseString
        bottomTextField.text = bottomTextField.text.uppercaseString
        return true
    }
}