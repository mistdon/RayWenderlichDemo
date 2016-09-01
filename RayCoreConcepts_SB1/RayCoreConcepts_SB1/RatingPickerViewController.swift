//
//  RatingPickerViewController.swift
//  RayCoreConcepts_SB1
//
//  Created by shendong on 16/9/1.
//  Copyright © 2016年 shendong. All rights reserved.
//

import UIKit

class RatingPickerViewController: UITableViewController {

    var selectedRating:String?{
        didSet{
            print("===== \(selectedRating)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RatingCell", forIndexPath: indexPath)
        let imageName = "\(indexPath.row+1)Stars"
        let image = UIImage(named: imageName)
        cell.imageView?.image = image
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedRating = "\(indexPath.row+1)"
        print(selectedRating)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
}
