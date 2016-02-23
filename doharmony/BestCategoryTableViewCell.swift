//
//  BestCategoryTableViewCell.swift
//  doharmony
//
//  Created by Mark Bermillo on 23/02/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class BestCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var UIimageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
