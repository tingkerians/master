//
//  MyFriendsTableViewCell.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/12/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class  FriendTableViewCell: UITableViewCell {

    @IBOutlet weak var ProfileName: UILabel!

    @IBOutlet weak var ProfilePicture: UIImageView!
    
    @IBAction func unfriendButton(sender: AnyObject) {
        print("unfriend")
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
