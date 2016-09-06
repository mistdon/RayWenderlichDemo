//
//  ManagerViewController.swift
//  PhotoScroll
//
//  Created by shendong on 16/9/6.
//  Copyright © 2016年 raywenderlich. All rights reserved.
//

import UIKit

class ManagerViewController: UIPageViewController {
    var photos = ["photo1", "photo2", "photo3", "photo4", "photo5"]
    var currentIndex: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
      dataSource = self
      
      if let viewController = viewPhotoCommentController(currentIndex ?? 0){
        let viewControllers = [viewController]
        setViewControllers(viewControllers,
                           direction: .Forward,
                           animated: false,
                           completion: nil)
      }

      
    }
    func viewPhotoCommentController(index: Int) ->PhotoCommentViewController?{
      if let storyboard = storyboard,
        page = storyboard.instantiateViewControllerWithIdentifier("PhotoCommentViewController") as? PhotoCommentViewController{
        page.photoName  = photos[index]
        page.photoIndex = index
        return page
      }
      return nil
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: implementation of UIPageViewControllerDataSource
extension ManagerViewController: UIPageViewControllerDataSource{
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    if let viewController = viewController as? PhotoCommentViewController{
        var index = viewController.photoIndex
      guard index != NSNotFound && index != 0 else { return nil}
      index = index - 1
      return viewPhotoCommentController(index)
    }
    return nil
  }
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    if let viewController = viewController as? PhotoCommentViewController{
      var index = viewController.photoIndex
      guard index != NSNotFound else {return nil}
      index = index + 1
      guard index != photos.count else { return nil}
      return viewPhotoCommentController(index)
    }
    return nil
  }
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return photos.count
  }
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return currentIndex ?? 0
    //This is another way to handle optional values is to provide a default value using the ?? operatore. If the optional value is missing, the default value is used instead
  }
}
