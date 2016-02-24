//
//  PopularTableViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/11/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class PopularTableViewController: UITableViewController {
    
    var TitleArray : [String] = ["Little Star", "Jingle Bell", "Canon", "Two Tiger", "Bayer No.8", "Silent Night", "The Painter", "Gavotte", "Minuet 1", "Moments"]
    var CoverArray : [String] = ["littleStar", "jingleBell", "canon", "default", "default", "default", "default", "default", "default", "default"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.registerNib(UINib(nibName: "PopularTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularTableViewCell")
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
        let cell : PopularTableViewCell = tableView.dequeueReusableCellWithIdentifier("PopularTableViewCell") as! PopularTableViewCell

        // Configure the cell...
//        if let label = cell.TitleLabel {
//            label.text = namesArray[indexPath.row]
//        }
//        if let image = cell.ImageView {
//            image.image = UIImage(named: photoNameArray[indexPath.row])
//        }
        cell.TitleLabel.text = TitleArray[indexPath.row]
        cell.ImageView.image = UIImage(named: CoverArray[indexPath.row])
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }

    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .darkGrayColor()
    }
    
    override func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
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
