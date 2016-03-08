//
//  UserDetailsTableViewCell.swift
//  doharmony
//
//  Created by Eleazer Toluan on 3/8/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {


    @IBOutlet weak var RelationshipImage: UIButton!
    @IBOutlet weak var ProfilePicture: UIImageView!
    let relationship = "friend"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        ProfilePicture.layer.cornerRadius = ProfilePicture.frame.width / 2
        FriendFollowButton(RelationshipImage)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func RelationshipButton(sender: AnyObject) {
        var Image : UIImage!
        if relationship == "friend" {
            Image = UIImage(named: "friend");
        } else if relationship == "following" {
            Image = UIImage(named: "follow");
        }
        let tintedImage = Image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        RelationshipImage.setImage(tintedImage, forState: .Normal)
        RelationshipImage.tintColor = UIColor.whiteColor()
        
       
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
        contentView.addSubview(RelationshipImage)
    }
}
