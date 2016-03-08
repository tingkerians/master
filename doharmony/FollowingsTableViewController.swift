//
//  FollowingsTableViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/22/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class FollowingsTableViewController: UITableViewController {
     
    var namesArray : [String] = ["Lauren Richard", "Nicholas Ray", "Kim White", "Charles Gray", "Timothy Jones", "Sarah Underwood", "William Pearl", "Juan Rodriguez", "Anna Hunt", "George Porter", "Zachary Hecker", "David Fletcher"]
    var photoNameArray : [String] = ["woman1", "man1", "woman2", "woman3", "man2", "man3", "man4", "man5", "woman4", "woman5", "man6" , "man8"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "FollowingsTableViewCell", bundle: nil), forCellReuseIdentifier: "FollowingsTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return namesArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FollowingsTableViewCell") as! FollowingsTableViewCell
        cell.selectionStyle = .None
        // Configure the cell...
        
        cell.ProfileName.text = namesArray[indexPath.row]
        cell.ProfilePicture.image = UIImage(named: photoNameArray[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
        let vc = UserDetailsViewController(nibName: "UserDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .darkGrayColor()
    }
    
    override func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }   
    
}
