//
// LocalTableViewCell.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/11/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class LocalTableViewCell: UITableViewCell {

    @IBOutlet weak var ImageView: UIImageView!

    @IBOutlet weak var TitleLabel: UILabel!

    @IBOutlet weak var authorLabel: UILabel!
    @IBAction func deleteTracks(sender: AnyObject) {
        print("delete")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        self.backgroundColor = UIColor .clearColor()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
