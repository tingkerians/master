//
//  LocalViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/24/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class LocalViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    
    var titleArray : [String] = ["Little Star", "Jingle Bell", "Canon", "Two Tiger", "Bayer No.8", "Silent Night", "The Painter", "Gavotte", "Minuet 1", "Moments"]
    var coverArray : [String] = ["littleStar", "jingleBell", "canon", "default", "default", "default", "default", "default", "default", "default"]
    
    var authorArray : [String] = ["daryl", "kim", "zer", "kyle", "rex", "mark", "rain", "kimor", "dc", "ton"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.registerNib(UINib(nibName: "LocalTableViewCell", bundle: nil), forCellReuseIdentifier: "LocalTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titleArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : LocalTableViewCell = tableView.dequeueReusableCellWithIdentifier("LocalTableViewCell") as! LocalTableViewCell
        
        cell.TitleLabel.text = titleArray[indexPath.row]
        cell.authorLabel.text = authorArray[indexPath.row]
        cell.ImageView.image = UIImage(named: coverArray[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
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
}
