//
//  PlayPostViewController.swift
//  doharmony
//
//  Created by eliakim on 2/15/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class TrackDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIScrollViewDelegate{

    @IBOutlet weak var CommentTableView: UITableView!
    
    var track: Track?
    var player: AVPlayer?
    
    @IBAction func closeButton(sender: AnyObject) {
        self.player = nil
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    let memberName = ["Daryl Decoyna", "Khemer", "Kyle", "Mark","Daryl Decoyna", "Eliakim","Daryl Decoyna", "Khemer", "Kyle", "Mark","Daryl Decoyna", "Eliakim"]
    let comment = ["In publishing and graphic design, lorem ipsum.", "The lorem ipsum text is typically a scrambled section of De finibus bonorum et malorum, a 1st-century BC Latin text by Cicero, with words altered, added, and removed to make it nonsensical, improper Latin.","Great!!!", "bye","In publishing and graphic design, lorem ipsum.", "hello wolrd","In publishing and graphic design, lorem ipsum.", "The lorem ipsum text is typically a scrambled section of De finibus bonorum et malorum, a 1st-century BC Latin text by Cicero, with words altered, added, and removed to make it nonsensical, improper Latin.","Great!!!", "bye","In publishing and graphic design, lorem ipsum.", "hello wolrd"]
    let profilePic = [UIImage(named: "man4"),UIImage(named: "man1"),UIImage(named: "man3"),UIImage(named: "man1"),UIImage(named: "man4"),UIImage(named: "man3"),UIImage(named: "man4"),UIImage(named: "man1"),UIImage(named: "man3"),UIImage(named: "man1"),UIImage(named: "man4"),UIImage(named: "man3")]

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        let fileUrl = env.apiUrl + "play/" + track!.id
        let url:NSURL = NSURL(string: fileUrl)!
        
        player = AVPlayer(URL: url)
        self.player?.play()
        
        self.CommentTableView.registerNib(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        self.CommentTableView.registerNib(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "playerCell")
        self.CommentTableView.registerNib(UINib(nibName: "TrackDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "trackDetailsCell")

    }
    func dismissKeyboard(){
               print("view click")
        view.endEditing(true)
    }
    func keyboardWillShow(sender: NSNotification) {
        print("keyboardWillShow")
        view.frame.origin.y -= 150
    }
    func keyboardWillHide(sender: NSNotification) {
        view.frame.origin.y += 150
        print("keyboardWillHide")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func numberOfSectionsInTableView(CommentTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(CommentTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mycount = self.profilePic.count
        return mycount
    }
    
    func tableView(CommentTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell : PlayerTableViewCell = CommentTableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath) as! PlayerTableViewCell
            cell.selectionStyle = .None
            cell.playerController.player = self.player
            return cell
            
        } else if (indexPath.row == 1){
            let cell : TrackDetailsTableViewCell = CommentTableView.dequeueReusableCellWithIdentifier("trackDetailsCell", forIndexPath: indexPath) as! TrackDetailsTableViewCell
            cell.selectionStyle = .None
            cell.titleLabel.text = track?.title
            cell.authorLabel.text = track?.authorName
            cell.likesLabel.text = track?.totalLikes
            cell.viewsLabel.text = track?.totalViews
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,0)) {
                if(self.track!.authorPic == nil){
                    self.track!.authorPic = UIImage(data: NSData(contentsOfURL: NSURL(string: self.track!.authorPicPath)!)!)
                }
                let photoArt = self.track!.authorPic
                dispatch_async(dispatch_get_main_queue()) {
                    if let futureCell = CommentTableView.cellForRowAtIndexPath(indexPath) as? TrackDetailsTableViewCell {
                        futureCell.userPicImage.image = photoArt
                        
                    }
                }
            }
            
            return cell

        }else {
            
            let cell : CommentTableViewCell = CommentTableView.dequeueReusableCellWithIdentifier("CommentTableViewCell") as! CommentTableViewCell
            cell.nameLabel?.text = self.memberName[indexPath.row]
            cell.commentLabel?.text = self.comment[indexPath.row]
            cell.profilePicImage.image = self.profilePic[indexPath.row]
            return cell
            
        }
    }

    func tableView(CommentTableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 263
        } else if (indexPath.row == 1){
            return 190.0
        }else {
            return 80.0
        }
    }
    
    
}
