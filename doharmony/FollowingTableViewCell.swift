//
//  FollowingsTableViewCell.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/22/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class FollowingTableViewCell: UITableViewCell {

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
        
        self.backgroundColor = UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)
        self.ProfilePicture.layer.masksToBounds = true
        self.ProfilePicture.layer.cornerRadius = self.ProfilePicture.frame.width / 3
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
