//
//  TrackDetailsTableViewCell.swift
//  doharmony
//
//  Created by eliakim on 3/9/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class TrackDetailsTableViewCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet var commentTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var viewsLabel: UILabel!
    @IBOutlet weak var userPicImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.commentTextView.text = "Add comment"
        self.commentTextView.textColor = UIColor.lightGrayColor()
        commentTextView.delegate = self
        
      
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap:")
        self.addGestureRecognizer(tapGesture)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func keyboardWillShow(sender: NSNotification) {
        self.frame.origin.y -= 150
    }
    func keyboardWillHide(sender: NSNotification) {
        self.frame.origin.y += 150
    }
    func textFieldShouldReturn(commentTextfield: UITextField) -> Bool {
        print("return keyboard")
        commentTextfield.resignFirstResponder()
        return true
    }
    func tap(gesture: UITapGestureRecognizer){
        commentTextView.text = ""
        commentTextView.resignFirstResponder()
    }
    // End dismiss keyboard
    
    func textViewDidBeginEditing(commentTextView: UITextView) {
        if commentTextView.textColor == UIColor.lightGrayColor(){
            commentTextView.text = nil
            commentTextView.textColor = UIColor.blackColor()
        }
        self.postButton.hidden = false
    }
    func textViewDidEndEditing(commentTextView: UITextView) {
        
        if commentTextView.text.isEmpty{
            commentTextView.text = "Add comment"
            commentTextView.textColor = UIColor.lightGrayColor()
        }
    }

}
