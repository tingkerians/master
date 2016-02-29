//
//  PopularTableViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/11/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import SwiftyJSON

class PopularBestTableViewController: UITableViewController {
    
    var data: [JSON]?
    var category: String?
    var date: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerNib(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentTableViewCell")
        let tracks = _tracks()
        tracks.setCategory(self.category!).request { (tracks) -> Void in
            self.data = tracks
            self.tableView.reloadData()
        }
        
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
        if(self.data == nil){
            return 0
        }else{
            return self.data!.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : RecentTableViewCell = tableView.dequeueReusableCellWithIdentifier("RecentTableViewCell") as! RecentTableViewCell

        let tracks = self.data!
        let coverArt: String = "http://192.168.0.137:8080/api/coverart/\(tracks[indexPath.row]["id"].stringValue)"
        
        cell.TitleLabel.text = tracks[indexPath.row]["title"].stringValue
        cell.ImageView.image =
            UIImage(data: NSData(contentsOfURL: NSURL(string: coverArt)!)!)
        cell.ViewLabel.text = tracks[indexPath.row]["views"].stringValue + ""
        cell.LikeLabel.text = tracks[indexPath.row]["likes"].stringValue + ""
        cell.DateLabel.text = tracks[indexPath.row]["date_updated"].stringValue
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }

    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .darkGrayColor()
    }
    
    override func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
    
    //search delegate
    func search(searchText: String) {
        let tracks = _tracks()
        tracks.setCategory(self.category!).setSearch(searchText).request { (tracks) -> Void in
            self.data = tracks
            self.tableView.reloadData()
        }
    }
}
