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
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var showLess: UIButton!
    @IBOutlet weak var seeMore: UIButton!
    var commentHeight = 0

    @IBAction func showLess(sender: AnyObject){
        self.frame.size.height = 80
        self.seeMore.hidden = false
        self.showLess.hidden = true
    }
    @IBAction func seeMore(sender: AnyObject) {
        let myHeight = 80
        let addHeight = commentHeight * 14
        let totalHeight = myHeight + addHeight
        self.frame.size.height = CGFloat(totalHeight)
        self.showLess.hidden = false
        self.seeMore.hidden = true
        print("see more \(commentHeight)")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("table view cell")
        self.showLess.hidden = true
        self.seeMore.hidden = true
        // Initialization code
    }
    
       override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
