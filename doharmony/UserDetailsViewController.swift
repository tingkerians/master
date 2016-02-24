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

    @IBOutlet weak var friendImage: UIButton!
    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet weak var TracksTableView: UITableView!

    
    var TitleArray : [String] = ["Little Star", "Jingle Bell", "Canon", "Two Tiger", "Bayer No.8", "Silent Night", "The Painter", "Gavotte", "Minuet 1", "Moments"]
    var CoverPhotoArray : [String] = ["littleStar", "jingleBell", "canon", "default", "default", "default", "default", "default", "default", "default"]
    let relationship = "friend"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ProfilePicture.layer.cornerRadius = ProfilePicture.frame.width / 2
        
        self.TracksTableView.registerNib(UINib(nibName: "UserTracksTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTracksTableViewCell")
//        self.TracksTableView.rowHeight = UITableViewAutomaticDimension
//        self.TracksTableView.setNeedsLayout()
//        self.TracksTableView.layoutIfNeeded()
        
        FriendFollowButton(friendImage)
    }

    
    @IBAction func unFriendFollowButton(sender: AnyObject) {
        var Image : UIImage!
        if relationship == "friend" {
            Image = UIImage(named: "friend");
        } else if relationship == "following" {
            Image = UIImage(named: "follow");
        }
        let tintedImage = Image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        friendImage.setImage(tintedImage, forState: .Normal)
        friendImage.tintColor = UIColor.whiteColor()
        
        self.dismissViewControllerAnimated(true, completion: nil)
        print("un\(relationship)!!!")
    }

    func FriendFollowButton(friendImage: UIButton) {
        if relationship == "friend" {
            friendImage.setImage(UIImage(named: "friend"), forState: UIControlState.Normal)
            friendImage.tintColor = UIColor.whiteColor()
        } else if relationship == "follow" {
            friendImage.setImage(UIImage(named: "follow"), forState: UIControlState.Normal)
            friendImage.tintColor = UIColor.orangeColor()
        }
        self.view.addSubview(friendImage)
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
        let cell : UserTracksTableViewCell = TracksTableView.dequeueReusableCellWithIdentifier("UserTracksTableViewCell") as! UserTracksTableViewCell
        
        cell.TitleLabel.text = TitleArray[indexPath.row]
        cell.ImageView.image = UIImage(named: CoverPhotoArray[indexPath.row])
        
        return cell
    }
    
    func tableView(TracksTableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }

    
    func tableView(TracksTableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = TrackDetailsViewController(nibName: "TrackDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
        
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
