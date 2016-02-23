//
//  RecentViewController.swift
//  doharmony
//
//  Created by eliakim on 2/19/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//
//  To do: 
//    Fetch data from server every `n` secs.
//    Fetching of initial data must be only done once, and not every navigation
//

import UIKit
import Alamofire
import SwiftyJSON

class RecentViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // Variable that will hold json results from the server
    var trackList: [JSON] = [];
    // Server url for `recently added` tracks
    let url = "http://192.168.0.137:8080/api/tracks";
    
    override func viewDidAppear(animated: Bool) {
        print("recent tracks");
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.delegate = self
        // Fetch data from the server if there's no existing data
        if trackList.count <= 0 {
            // Fetch json of `recently` added tracks
            fetchTrackData();
        }
        self.tableView.registerNib(UINib(nibName: "RecentTableViewCell", bundle: nil), forCellReuseIdentifier: "RecentTableViewCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    Fetch track data from the server and store it in the `trackList` variable
    */
    func fetchTrackData() {
        print("fetching `recent tracks` data");
        
        Alamofire.request(.GET, url, parameters: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let result = JSON(response.result.value!);
                    if let data = result["data"].arrayValue as [JSON]?{
                        self.trackList = data;
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

    func scrollViewDidScroll(scrollView: UIScrollView) {
        SearchBar.resignFirstResponder()
        print("scrolllllllllling")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return trackList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : RecentTableViewCell = tableView.dequeueReusableCellWithIdentifier("RecentTableViewCell") as! RecentTableViewCell
        
        let coverArt: String = "http://192.168.0.137:8080/api/coverart/\(trackList[indexPath.row]["id"].stringValue)";
        
        cell.titleLabel.text = trackList[indexPath.row]["title"].stringValue;
        cell.UIimageView.image =
            UIImage(data: NSData(contentsOfURL: NSURL(string: coverArt)!)!);
        cell.authorLabel.text = trackList[indexPath.row]["author"].stringValue;
        cell.publishDate.text = trackList[indexPath.row]["publish_date"].stringValue;
        return cell
    }
    
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    var valueToPass = "hello world"
   func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = TrackDetailsViewController(nibName: "TrackDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
        
    
    }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
