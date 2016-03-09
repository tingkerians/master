//
//  TabBarController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/10/16.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {


    @IBOutlet weak var tabBarItems: UITabBar!
    
    let barColor = UIColor(red: 41.0/255.0, green: 40.0/255.0, blue: 39.0/255.0, alpha: 1.0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().barTintColor = barColor
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        self.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -16, 0)
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame: CGRect = self.tabBar.frame
        //self.TabBar is IBOutlet of your TabBar
        tabFrame.size.height = 60
        tabFrame.origin.y = self.view.frame.size.height - 50
        self.tabBar.frame = tabFrame
    }
  
    
}