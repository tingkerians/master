//
//  FollowingsTableViewCell.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/22/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class FollowingsTableViewCell: UITableViewCell {

    @IBOutlet weak var ProfilePicture: UIImageView!
    
    @IBOutlet weak var ProfileName: UILabel!
    
    @IBAction func unfollowButton(sender: AnyObject) {
        print("unfollow!!!")
    }
    
    @IBAction func viewTracksButton(sender: AnyObject) {
        print("view tracks")
    }
    
    @IBAction func contactButton(sender: AnyObject) {
        print("contact")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor .clearColor()
        self.ProfilePicture.layer.masksToBounds = true
        self.ProfilePicture.layer.cornerRadius = self.ProfilePicture.frame.width / 3
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
