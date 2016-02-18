//
//  TestTableViewController.swift
//  NFTopMenuController
//
//  Created by Niklas Fahl on 12/17/14.
//  Copyright (c) 2014 Niklas Fahl. All rights reserved.
//

import UIKit

class RecentlyTableViewController: UITableViewController {
    
    var namesArray : [String] = ["Lauren Richard", "Nicholas Ray", "Kim White", "Charles Gray", "Timothy Jones", "Sarah Underwood", "William Pearl", "Juan Rodriguez", "Anna Hunt", "Marie Turner", "George Porter", "Zachary Hecker", "David Fletcher"]
    var photoNameArray : [String] = ["tab-menu", "tab-home"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("recent")
        self.tableView.registerNib(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 2
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : FriendTableViewCell = tableView.dequeueReusableCellWithIdentifier("FriendTableViewCell") as! FriendTableViewCell

        // Configure the cell...
        cell.nameLabel.text = namesArray[indexPath.row]
        cell.photoImageView.image = UIImage(named: photoNameArray[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64.0
    }
}