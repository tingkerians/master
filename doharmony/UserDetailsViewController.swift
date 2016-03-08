//
//  UserDetailsViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/22/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBAction func closeButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


    @IBOutlet weak var TracksTableView: UITableView!
    
    var TitleArray : [String] = ["Little Star", "Jingle Bell", "Canon", "Two Tiger", "Bayer No.8", "Silent Night", "The Painter", "Gavotte", "Minuet 1", "Moments"]
    var CoverPhotoArray : [String] = ["littleStar", "jingleBell", "canon", "default", "default", "default", "default", "default", "default", "default"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
        
        self.TracksTableView.registerNib(UINib(nibName: "UserTracksTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTracksCell")
        self.TracksTableView.registerNib(UINib(nibName: "UserDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "UserDetailsCell")
//        self.TracksTableView.registerNib(UINib(nibName: "UserTracksTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTracksTableViewCell")
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(TracksTableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(TracksTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TitleArray.count
    }
    
    func tableView(TracksTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell : UserDetailsTableViewCell = TracksTableView.dequeueReusableCellWithIdentifier("UserDetailsCell", forIndexPath: indexPath) as! UserDetailsTableViewCell
            cell.selectionStyle = .None
            return cell
            
        } else {
            let cell : UserTracksTableViewCell = TracksTableView.dequeueReusableCellWithIdentifier("UserTracksCell", forIndexPath: indexPath) as! UserTracksTableViewCell
            cell.selectionStyle = .None
            cell.TitleLabel.text = TitleArray[indexPath.row]
            cell.ImageView.image = UIImage(named: CoverPhotoArray[indexPath.row])
            
            return cell
            
        }
        
       
    }
    
    func tableView(TracksTableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 230.0
        }else {
            return 50.0
        }
    }

    
    func tableView(TracksTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row != 0 {
            let vc = TrackDetailsViewController(nibName: "TrackDetailsViewController", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
