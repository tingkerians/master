//
//  PopularCategoryTableViewController.swift
//  doharmony
//
//  Created by Mark Bermillo on 23/02/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//
// This `PopularCategoryTableViewController` will be the controller for the 3 subviews
// under `Popular` tab navigation, namely: `Last Week`, `Last Month`, and
// `All Time`

import UIKit
import SwiftyJSON

class PopularCategoryTableViewController: UITableViewController {
    
    // Variable that will hold json results from the server
    var trackList: [JSON] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad();
        self.tableView.registerNib(UINib(nibName: "PopularCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularCategoryTableViewCell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trackList.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : PopularCategoryTableViewCell = tableView.dequeueReusableCellWithIdentifier("PopularCategoryTableViewCell") as! PopularCategoryTableViewCell
        
        let coverArt: String = "http://192.168.0.137:8080/api/coverart/\(trackList[indexPath.row]["id"].stringValue)";
        
        cell.titleLabel.text = trackList[indexPath.row]["title"].stringValue;
        cell.UIimageView.image =
            UIImage(data: NSData(contentsOfURL: NSURL(string: coverArt)!)!);
        cell.authorLabel.text = trackList[indexPath.row]["author"].stringValue;
        cell.viewsLabel.text = trackList[indexPath.row]["views"].stringValue;
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
