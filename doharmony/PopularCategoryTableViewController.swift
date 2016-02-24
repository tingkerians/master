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
import Alamofire
import SwiftyJSON

class PopularCategoryTableViewController: UITableViewController {
    
    // Variable that will hold json results from the server
    var tracks = [JSON]();
    // `timeCategory` is used in determining the `data` to be fetched
    // from the server i9.e. last week, last month, or all time
    var timeCategory = String();
    // Server url for fetching tracks data
    let url = "http://192.168.0.137:8080/api/tracks";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Fetch data from the server if there's no existing data
        if tracks.count <= 0 {
            // Fetch json of `popular` tracks
            fetchTrackData();
        }
        self.tableView.registerNib(UINib(nibName: "PopularCategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "PopularCategoryTableViewCell");
    }
    
    /*
    Fetch track data from the server and store it in the `tracks` variable
    */
    func fetchTrackData() {
        print("fetching `popular tracks` data");

        let parameters = [
            "category" : "popular",
            "date" : timeCategory
        ];
        
        Alamofire.request(.GET, url, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let result = JSON(response.result.value!);
                    if let data = result["data"].arrayValue as [JSON]?{
                        self.tracks = data;
                        self.tableView.reloadData();
                    }
                    
                case .Failure(let error):
                    print("HTTP RESPONSE:\n\(response.response)");
                    self.showAlert("Fetch data failed", message: String(error.localizedDescription));
                }
        }
        return;
    }
    
    /*
    Used to show alerts and message
    */
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
            message: message, preferredStyle: .Alert);
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil);
        
        alert.addAction(action);
        
        self.presentViewController(alert, animated: true, completion: nil);
        return;
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
        return tracks.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : PopularCategoryTableViewCell = tableView.dequeueReusableCellWithIdentifier("PopularCategoryTableViewCell") as! PopularCategoryTableViewCell
        
        let coverArt: String = "http://192.168.0.137:8080/api/coverart/\(tracks[indexPath.row]["id"].stringValue)";
        
        cell.titleLabel.text = tracks[indexPath.row]["title"].stringValue;
        cell.UIimageView.image =
            UIImage(data: NSData(contentsOfURL: NSURL(string: coverArt)!)!);
        cell.authorLabel.text = tracks[indexPath.row]["author"].stringValue;
        cell.viewsLabel.text = tracks[indexPath.row]["views"].stringValue;
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
