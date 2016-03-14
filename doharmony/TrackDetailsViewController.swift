//
//  PlayPostViewController.swift
//  doharmony
//
//  Created by eliakim on 2/15/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class TrackDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIScrollViewDelegate{
    @IBOutlet weak var ScrollView: UIScrollView!
    var label = UILabel()
    
    @IBOutlet weak var commentBox: UIView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet weak var CommentTableView: UITableView!
    @IBOutlet weak var TrackTitle: UILabel!
    
    @IBAction func closeButton(sender: AnyObject) {
        print("close")
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

        self.CommentTableView.registerNib(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        self.CommentTableView.registerNib(UINib(nibName: "PlayerTableViewCell", bundle: nil), forCellReuseIdentifier: "playerCell")
        self.CommentTableView.registerNib(UINib(nibName: "TrackDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "trackDetailsCell")

    }
    func dismissKeyboard(){
        view.endEditing(true)
    }
    func keyboardWillShow(sender: NSNotification) {
        let userInfo:NSDictionary = sender.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        let keyboardHeight = keyboardRectangle.height
        view.frame.origin.y -= keyboardHeight
        print("keyboardWillShow \(keyboardHeight)")
        
    }
    func keyboardWillHide(sender: NSNotification) {
        let userInfo:NSDictionary = sender.userInfo!
        let keyboardFrame:NSValue = userInfo.valueForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.CGRectValue()
        let keyboardHeight = keyboardRectangle.height
        view.frame.origin.y += keyboardHeight
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
            return cell
            
        } else if (indexPath.row == 1){
            let cell : TrackDetailsTableViewCell = CommentTableView.dequeueReusableCellWithIdentifier("trackDetailsCell", forIndexPath: indexPath) as! TrackDetailsTableViewCell
            cell.selectionStyle = .None
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
            let bounds = UIScreen.mainScreen().bounds
            let screenWidth = bounds.size.width
            print("screenWidth: \(screenWidth)")
            return screenWidth
        } else if (indexPath.row == 1){
            return 190.0
        }else {
            return 80.0
        }
    }
    
    
}
