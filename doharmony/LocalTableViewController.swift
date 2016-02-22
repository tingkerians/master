//
//  LocalTableViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/11/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class LocalTableViewController: UITableViewController {
    
    var namesArray : [String] = ["Little Star", "Jingle Bell", "Canon", "Two Tiger", "Bayer No.8", "Silent Night", "The Painter", "Gavotte", "Minuet 1", "Moments"]
    var photoNameArray : [String] = ["littleStar", "jingleBell", "canon", "default", "default", "default", "default", "default", "default", "default"]

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
        return namesArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : LocalTableViewCell = tableView.dequeueReusableCellWithIdentifier("LocalTableViewCell") as! LocalTableViewCell

        cell.TitleLabel.text = namesArray[indexPath.row]
        cell.ImageView.image = UIImage(named: photoNameArray[indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
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
