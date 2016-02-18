//
//  CommentTableViewCell.swift
//  doharmony
//
//  Created by eliakim on 2/16/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var commentLabel: UITextView!
       
    override func awakeFromNib() {
        super.awakeFromNib()
        print("table view cell")
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
