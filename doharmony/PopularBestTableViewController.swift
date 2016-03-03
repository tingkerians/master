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
    
    var data: [Track]?
    var category: String?
    var date: String?
    var tracks: Tracks!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentTableViewCell")
        
        self.tracks = Tracks.sharedInstance
        
//        if(self.tracks.data == nil){
            self.tracks.setCategory(self.category!).setDate(self.date!).request { (tracks) -> Void in
                self.data = tracks
                self.tableView.reloadData()
            }
//        }else{
//            self.data = self.tracks.data!.sort({ (track1, track2) -> Bool in
//                if(self.category == "popular"){
//                    return track1.totalViews > track2.totalViews
//                }else{
//                    return track1.totalLikes > track2.totalLikes
//                }
//            })
//            self.tableView.reloadData()
//        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
        let coverArt: String = tracks[indexPath.row].imagePath
        
        cell.TitleLabel.text = tracks[indexPath.row].title
        cell.ImageView.image =
            UIImage(data: NSData(contentsOfURL: NSURL(string: coverArt)!)!)
        cell.ViewLabel.text = tracks[indexPath.row].totalViews + "V"
        cell.LikeLabel.text = tracks[indexPath.row].totalLikes + "L"
        cell.DateLabel.text = tracks[indexPath.row].dateUpdated
        return cell
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }

    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .darkGrayColor()
    }
    
    override func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = TrackDetailsViewController(nibName: "TrackDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
//    //search delegate
//    func search(searchText: String) {
//        self.tracks!.setCategory(self.category!).setSearch(searchText).request { (tracks) -> Void in
//            self.data = tracks
//            self.tableView.reloadData()
//        }
//    }
}
