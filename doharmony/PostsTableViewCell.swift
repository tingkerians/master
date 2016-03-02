//
//  PostsTableViewCell.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/12/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var ProfilePicture: UIImageView!
    @IBOutlet weak var ProfileName: UILabel!
    @IBOutlet weak var PostTitle: UILabel!
    @IBOutlet weak var PostCover: UIImageView!
    @IBOutlet weak var PostView: UILabel!
    @IBOutlet weak var PostLike: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.ProfilePicture.layer.masksToBounds = true
        self.ProfilePicture.layer.cornerRadius = self.ProfilePicture.frame.width / 2
        

//        nameTapAction()
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("nameTapAction:"))
        tap.delegate = self
        ProfileName.addGestureRecognizer(tap)
        
    }
    
    func nameTapAction(gestureRecognizer: UITapGestureRecognizer) {
        print("tapped")
        // handling code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func unButton(sender: AnyObject) {
        print("unfriend")
    }
    
    @IBAction func viewTracksButton(sender: AnyObject) {
            print("view tracks")
    }
    
    @IBAction func contactButton(sender: AnyObject) {
        print("contact")
    }
//    func toPlayPost(sender: UITapGestureRecognizer){
//                Template = sender.view
//                for subview:UIView in Template.subviews{
//                    Frames.append(subview)
//                }
//                self.performSegueWithIdentifier("toRecordingPage", sender: sender)
//    }
//
}
