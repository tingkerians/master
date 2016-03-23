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
    
    @IBOutlet weak var commentBox: UIView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet weak var CommentTableView: UITableView!
    @IBOutlet weak var TrackTitle: UILabel!
    var label = UILabel()
    @IBAction func closeButton(sender: AnyObject) {
        print("close")
        self.dismissViewControllerAnimated(false, completion: nil)
    }
//    var i = 0
    let memberName = ["Kyle", "Mark","Daryl Decoyna", "Eliakim","Daryl Decoyna", "Khemer", "Kyle", "Mark","Daryl Decoyna", "Eliakim"]
    let comment = ["In publishing and graphic design, lorem ipsum.", "The lorem ipsum text is typically a scrambled section of De finibus bonorum et malorum, a 1st-century BC Latin text by Cicero, with words altered, added, and removed to make it nonsensical, improper Latin","Great!!!", "bye","In publishing and graphic design, lorem ipsum.", "hello wolrd","In publishing and graphic design, lorem ipsum.", "The lorem ipsum text is typically a scrambled section of De finibus bonorum et malorum, a 1st-century BC Latin text by Cicero, with words altered, added, and removed to make it nonsensical, improper Latin with words altered, added, and removed to make it nonsensical, improper Latin,The lorem ipsum text is typically a scrambled section of De finibus bonorum et malorum, a 1st-century BC Latin text by Cicero, with words altered, added, and removed to make it nonsensical, improper Latin with words altered, added, and removed to make it nonsensical, improper Latin.","Great!!!", "bye"]
    let profilePic = [UIImage(named: "man4"),UIImage(named: "man1"),UIImage(named: "man3"),UIImage(named: "man1"),UIImage(named: "man4"),UIImage(named: "man3"),UIImage(named: "man4"),UIImage(named: "man1"),UIImage(named: "man3"),UIImage(named: "man1")]
    var seeMoreStatus = [Bool]()
    var myCommentlHeight = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds = UIScreen.mainScreen().bounds
        let screenWidth = bounds.size.width
        let size = CGSize(width: screenWidth - 125, height: 1000)
        let font = UIFont (name: "HelveticaNeue-UltraLight", size: 14)
        
        for var i = 0; i < self.comment.count; i++ {
            let numberOflines = numberOfLinesForString(comment[i], size: size, font: font!)
            myCommentlHeight.append(numberOflines)
            if numberOflines > 2 {
                seeMoreStatus.append(false)
            } else {
                seeMoreStatus.append(true)
            }
        }
        print(seeMoreStatus)
        print(myCommentlHeight)
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
        return self.profilePic.count + 2
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
            cell.nameLabel?.text = self.memberName[indexPath.row - 2]
            cell.commentLabel?.text = self.comment[indexPath.row - 2]
            cell.profilePicImage.image = self.profilePic[indexPath.row - 2]
//seeMore            cell.seeMore.hidden = self.seeMoreStatus[indexPath.row - 2]
            cell.commentHeight = self.myCommentlHeight[indexPath.row - 2]
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
            let commentHeight = self.myCommentlHeight[indexPath.row - 2]
            let myHeight = 80
            let addHeight = commentHeight * 14
            let totalHeight = myHeight + addHeight
            return CGFloat(totalHeight)
        }
    }
    func numberOfLinesForString(string: String, size: CGSize, font: UIFont) -> Int {
        let textStorage = NSTextStorage(string: string, attributes: [NSFontAttributeName: font])
        
        let textContainer = NSTextContainer(size: size)
        textContainer.lineBreakMode = .ByWordWrapping
        textContainer.maximumNumberOfLines = 0
        textContainer.lineFragmentPadding = 0
        
        let layoutManager = NSLayoutManager()
        layoutManager.textStorage = textStorage
        layoutManager.addTextContainer(textContainer)
        
        var numberOfLines = 0
        var index = 0
        var lineRange : NSRange = NSMakeRange(0, 0)
        for (; index < layoutManager.numberOfGlyphs; numberOfLines++) {
            layoutManager.lineFragmentRectForGlyphAtIndex(index, effectiveRange: &lineRange)
            index = NSMaxRange(lineRange)
        }
       
        return numberOfLines
    }

    
}
