//
//  RecentViewController.swift
//  doharmony
//
//  Created by eliakim on 2/19/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import SwiftyJSON
//import SwiftSpinner

class RecentViewController: UIViewController, UITableViewDelegate{
    
    
    @IBOutlet weak var NoInternetAccess: UIView!

    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var refreshControl: UIRefreshControl!
//    self.NoConnection.h
    var data: [Track]?
    var tracks: Tracks!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let nibView = NSBundle.mainBundle().loadNibNamed("NoInternetAccessViewController", owner: self, options: nil)[0] as! UIView
        self.NoInternetAccess.addSubview(nibView)

//        self.tableView.registerNib(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentTableViewCell")
//        self.tracks = Tracks.sharedInstance
//        if(self.tracks.data == nil){
//            self.tracks!.setCategory("recent").request { (tracks) -> Void in
//                
//                self.refreshControl = UIRefreshControl()
//                self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//                self.refreshControl.addTarget(self, action: "didRefresh:", forControlEvents: UIControlEvents.ValueChanged)
//                self.tableView.addSubview(self.refreshControl)
//                
//                self.data = tracks
//                self.tableView.reloadData()
//                self.ActivityIndicator.stopAnimating()
//                
//            }
//        }else{
//            self.data = self.tracks.data!
//            self.tableView.reloadData()
//        }
    }
    func didRefresh(sender:AnyObject)
    {
        self.refreshControl.endRefreshing()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(self.data == nil){
            return 0
        }else{
            return self.data!.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : RecentTableViewCell = tableView.dequeueReusableCellWithIdentifier("RecentTableViewCell") as! RecentTableViewCell
        
        let tracks = self.data!
        let coverArt: String = tracks[indexPath.row].imagePath
        
        cell.TitleLabel.text = tracks[indexPath.row].title
        cell.ImageView.image =
            UIImage(data: NSData(contentsOfURL: NSURL(string: coverArt)!)!)
        cell.ViewLabel.text = tracks[indexPath.row].totalViews
        cell.LikeLabel.text = tracks[indexPath.row].totalLikes
        cell.DateLabel.text = tracks[indexPath.row].dateUpdated
        return cell
    }
    
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }

   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let vc = TrackDetailsViewController(nibName: "TrackDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)

    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
    
    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
    
//    //search delegate
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        self.tracks!.setCategory("recent").setSearch(searchText).request { (tracks) -> Void in
//            self.data = tracks
//            self.tableView.reloadData()
//        }
//    }
//    
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        searchBar.endEditing(true)
//    }

}
