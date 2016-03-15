//
//  PopularTableViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/11/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import Alamofire

class PopularBestTableViewController: UITableViewController {
    
    var data: [Track]?
    var category: String?
    var date: String?
    var tracks: Tracks!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentTableViewCell")
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.tintColor = UIColor.whiteColor()
        self.refreshControl!.addTarget(self, action: "reloadData", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refreshControl!)
        
        let nc = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "search", name: "searchHome", object: nil)
        //check for internet connection
        let nibView = NoInternetAccessViewController(nibName: "NoInternetAccessViewController", bundle: nil)
        self.tableView.addSubview(nibView.view)
        
        let manager = NetworkReachabilityManager(host: "www.apple.com")
        manager?.listener = { status in
            if  manager?.isReachable == false {
                nibView.view.hidden = false
            }else{
                if(self.data == nil || self.data!.count == 0){
                    self.tableView.contentOffset = CGPointMake(0, -self.refreshControl!.frame.size.height)
                    self.refreshControl!.beginRefreshing()
                    self.reloadData()
                }
                nibView.view.hidden = true
            }
        }
        manager?.startListening()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if(self.data == nil || self.data!.count == 0){
            self.tableView.contentOffset = CGPointMake(0, -self.refreshControl!.frame.size.height)
            self.refreshControl!.beginRefreshing()
            reloadData()
        }
    }
    
    func reloadData(){
        self.tracks = Tracks.sharedInstance
        self.tracks.setCategory(self.category!).setDate(self.date!).request { (tracks) -> Void in
            if(tracks.count > 0){
                self.data = tracks
                self.tableView.reloadData()
            }
            self.refreshControl!.performSelector("endRefreshing", withObject: nil, afterDelay: 0.5)
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
        
        cell.TitleLabel.text = tracks[indexPath.row].title
        cell.ViewLabel.text = tracks[indexPath.row].totalViews
        cell.LikeLabel.text = tracks[indexPath.row].totalLikes
        cell.DateLabel.text = tracks[indexPath.row].dateUpdated
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0)) {
            if(tracks[indexPath.row].image == nil){
                tracks[indexPath.row].image = UIImage(data: NSData(contentsOfURL: NSURL(string: tracks[indexPath.row].imagePath)!)!)
            }
            let coverArt = tracks[indexPath.row].image
            dispatch_async(dispatch_get_main_queue()) {
                if let futureCell = tableView.cellForRowAtIndexPath(indexPath) as? RecentTableViewCell {
                    futureCell.ImageView.image = coverArt
                    
                }
            }
        }
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
        let tracks = self.data!
        let vc = TrackDetailsViewController(nibName: "TrackDetailsViewController", bundle: nil)
        vc.track = tracks[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    func search() {
        self.tableView.contentOffset = CGPointMake(0, -self.refreshControl!.frame.size.height)
        self.refreshControl!.beginRefreshing()
        reloadData()
    }
}
