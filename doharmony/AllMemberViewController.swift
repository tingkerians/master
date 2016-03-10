//
//  AllMemberViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 3/10/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class AllMemberViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var TableView: UITableView!

    var namesArray : [String] = ["Lauren Richard", "Nicholas Ray", "Kim White", "Charles Gray", "Timothy Jones", "Sarah Underwood", "William Pearl", "Juan Rodriguez", "Anna Hunt", "George Porter", "Zachary Hecker", "David Fletcher"]
    var photoNameArray : [String] = ["woman1", "man1", "woman2", "woman3", "man2", "man3", "man4", "man5", "woman4", "woman5", "man6" , "man8"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.TableView.registerNib(UINib(nibName: "AllMemberTableViewCell", bundle: nil), forCellReuseIdentifier: "AllMemberTableViewCell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(TableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return namesArray.count
    }
    
    
    func tableView(TableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCellWithIdentifier("AllMemberTableViewCell") as! AllMemberTableViewCell
        cell.selectionStyle = .None
        // Configure the cell...
        
        cell.ProfileName.text = namesArray[indexPath.row]
        cell.ProfilePicture.image = UIImage(named: photoNameArray[indexPath.row])
        
        return cell
    }
    
    func tableView(TableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    
    
    func tableView(TableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = UserDetailsViewController(nibName: "UserDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func tableView(TableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = TableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .darkGrayColor()
    }
    
    func tableView(TableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = TableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
}
