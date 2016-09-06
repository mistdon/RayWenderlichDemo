//
//  PhotoCommentViewController.swift
//  PhotoScroll
//
//  Created by shendong on 16/9/6.
//  Copyright © 2016年 raywenderlich. All rights reserved.
//

import UIKit

class PhotoCommentViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var nameTextField: UITextField!
  public var photoName: String!
  public var photoIndex: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
      if  let photoName = photoName {
        self.imageView.image = UIImage(named: photoName)
      }
      
      NSNotificationCenter.defaultCenter().addObserver(self,
                                                       selector: #selector(PhotoCommentViewController.keyboardWillShow(_:)),
                                                       name: UIKeyboardWillShowNotification,
                                                       object: nil)
      NSNotificationCenter.defaultCenter().addObserver(self,
                                                       selector: #selector(PhotoCommentViewController.keyboardWillHide(_:)),
                                                       name: UIKeyboardWillHideNotification,
                                                       object: nil)
      
    }
    //MARK: NSNotificationCenter method
    func adjustINsetForKeyboardShow(show: Bool, notification: NSNotification){
      guard let value = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue else { return }
      let keyboardFrame = value.CGRectValue()
      let adjustmentHeight = (CGRectGetHeight(keyboardFrame) + 20) * (show ? 1 : -1)
      scrollView.contentInset.bottom += adjustmentHeight
      scrollView.scrollIndicatorInsets.bottom += adjustmentHeight
    }
    func keyboardWillShow(notification: NSNotification){
      adjustINsetForKeyboardShow(true, notification: notification)
    }
    func keyboardWillHide(notificaiton: NSNotification){
      adjustINsetForKeyboardShow(false, notification: notificaiton)
    }
  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit{
      NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    @IBAction func hideKeyboard(sender: AnyObject){
      nameTextField.endEditing(true)
    }
  @IBAction func openZoomingController(sender: AnyObject){
      self.performSegueWithIdentifier("zooming", sender: nil)
  }

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      if let id = segue.identifier, zoomedphotoViewController = segue.destinationViewController as? ZoomedPhotoViewController {
        if id == "zooming" {
          zoomedphotoViewController.photoName = photoName
        }
      }
    }
 

}
