//
//  PlayPostViewController.swift
//  doharmony
//
//  Created by eliakim on 2/15/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class TrackDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate, UIScrollViewDelegate{
    var label = UILabel()
    @IBOutlet weak var commentBoxHeight: NSLayoutConstraint!
    @IBOutlet weak var commentBox: UIView!
    
    @IBOutlet weak var postButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet weak var CommentTableView: UITableView!
    @IBOutlet weak var TrackTitle: UILabel!
    
    @IBAction func closeButton(sender: AnyObject) {
        print("close")
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    
    let memberName = ["Daryl Decoyna", "Khemer", "Kyle", "Mark"]
    let comment = ["In publishing and graphic design, lorem ipsum.", "The lorem ipsum text is typically a scrambled section of De finibus bonorum et malorum, a 1st-century BC Latin text by Cicero, with words altered, added, and removed to make it nonsensical, improper Latin.","Great!!!", "bye"]
    let profilePic = [UIImage(named: "man4"),UIImage(named: "man1"),UIImage(named: "man3"),UIImage(named: "man1")]

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.TrackTitle.label = self.TrackTitle

        self.commentBoxHeight.constant = 60
        self.postButton.hidden = true
        self.postButtonHeight.constant = 0
        self.commentTextView.text = "Add comment"
        self.commentTextView.textColor = UIColor.lightGrayColor()
        
        self.CommentTableView.registerNib(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        self.CommentTableView.estimatedRowHeight = 80
        self.CommentTableView.rowHeight = UITableViewAutomaticDimension

        self.CommentTableView.setNeedsLayout()
        self.CommentTableView.layoutIfNeeded()
        
        commentTextView.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func numberOfSectionsInTableView(CommentTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(CommentTableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberName.count
    }
    
    func tableView(CommentTableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : CommentTableViewCell = CommentTableView.dequeueReusableCellWithIdentifier("CommentTableViewCell") as! CommentTableViewCell
        cell.selectionStyle = .None
        cell.nameLabel?.text = self.memberName[indexPath.row]
        cell.commentLabel?.text = self.comment[indexPath.row]
        cell.profilePicImage.image = self.profilePic[indexPath.row]
        return cell
    }
    
    func tableView(CommentTableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80.0
    }
    // Dismiss Keyboard
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 150
    }
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 150
    }
    func textFieldShouldReturn(commentTextfield: UITextField) -> Bool {
        print("return keyboard")
        commentTextfield.resignFirstResponder()
        return true
    }
    func tap(gesture: UITapGestureRecognizer){
        commentTextView.resignFirstResponder()
    }
    // End dismiss keyboard
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.commentBoxHeight.constant = 0
        self.commentBox.hidden = true
//        print("scrolllllllllling")
        
        
        let scrollOffset = scrollView.contentOffset.y
        if scrollOffset == 0{
            self.commentBoxHeight.constant = 60
            self.commentBox.hidden = false
        }
    }
    func textViewDidBeginEditing(commentTextView: UITextView) {
        if commentTextView.textColor == UIColor.lightGrayColor(){
            commentTextView.text = nil
            commentTextView.textColor = UIColor.blackColor()
        }
        self.commentBoxHeight.constant = 100
        self.postButtonHeight.constant = 20
        self.postButton.hidden = false
    }
    func textViewDidEndEditing(commentTextView: UITextView) {
        self.commentBoxHeight.constant = 60
        self.postButtonHeight.constant = 0
        self.postButton.hidden = true
        if commentTextView.text.isEmpty{
            commentTextView.text = "Add comment"
            commentTextView.textColor = UIColor.lightGrayColor()
        }
    }
}
