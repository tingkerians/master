//
//  PlayerTableViewCell.swift
//  doharmony
//
//  Created by eliakim on 3/9/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var playerSlider: UISlider!
    var playerController = AVPlayerViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playerController.view.frame = self.bounds
        self.addSubview(playerController.view)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
