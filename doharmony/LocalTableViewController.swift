//
//  LocalTableViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/11/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class LocalTableViewController: UITableViewController {
    
    var TitleArray : [String] = ["Little Star", "Jingle Bell", "Canon", "Two Tiger", "Bayer No.8", "Silent Night", "The Painter", "Gavotte", "Minuet 1", "Moments"]
    var CoverArray : [String] = ["littleStar", "jingleBell", "canon", "default", "default", "default", "default", "default", "default", "default"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("recent")
        self.tableView.registerNib(UINib(nibName: "LocalTableViewCell", bundle: nil), forCellReuseIdentifier: "LocalTableViewCell")
        
//        var nib = UINib(nibName: "TrackDetailsViewController", bundle: nil)
//        self.registerNib(nib, forCellReuseIIdentifier: "cell")
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
        return TitleArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : LocalTableViewCell = tableView.dequeueReusableCellWithIdentifier("LocalTableViewCell") as! LocalTableViewCell

        cell.TitleLabel.text = TitleArray[indexPath.row]
        cell.ImageView.image = UIImage(named: CoverArray[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    var valueToPass = "hello world"
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
 
        let vc = PlayTrackViewController(nibName: "PlayTrackViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
        
//        let indexPath = tableView.indexPathForSelectedRow!
//        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
//        
//        
//        performSegueWithIdentifier("TrackDetailsViewController", sender: self)
    }
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "TrackDetailsViewController" {
//            let viewController = segue.destinationViewController as! TrackDetailsViewController
//            
//            viewController.TrackTitle = valueToPass
//            print("im kim")
//        }
//    }
   
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .darkGrayColor()
    }
    
    override func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
}
