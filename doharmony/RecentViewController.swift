//
//  RecentViewController.swift
//  doharmony
//
//  Created by eliakim on 2/19/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//
//

import UIKit
import Alamofire
import SwiftyJSON

class RecentViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate{
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // Variable that will hold json results from the server
    var tracks = [JSON]();
    // Server url for tracks data
    let url = "http://192.168.0.137:8080/api/tracks";
    
    override func viewDidAppear(animated: Bool) {
//        print("recent tracks");
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.delegate = self
        // Fetch data from the server if there's no existing data
        if tracks.count <= 0 {
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
    Fetch track data from the server and store it in the `tracks` variable
    */
    func fetchTrackData() {
        print("fetching `recent tracks` data");
        
        let parameters = [
            "category" : "recent"
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
        return tracks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : RecentTableViewCell = tableView.dequeueReusableCellWithIdentifier("RecentTableViewCell") as! RecentTableViewCell
        
        let coverArt: String = "http://192.168.0.137:8080/api/coverart/\(tracks[indexPath.row]["id"].stringValue)";
        cell.titleLabel.text = tracks[indexPath.row]["title"].stringValue;
        cell.UIimageView.image =
            UIImage(data: NSData(contentsOfURL: NSURL(string: coverArt)!)!);
        cell.authorLabel.text = tracks[indexPath.row]["author"].stringValue;
        cell.publishDate.text = tracks[indexPath.row]["date_created"].stringValue;
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
