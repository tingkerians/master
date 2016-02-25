//
//  ViewController.swift
//  PageMenuDemoStoryboard
//
//  Created by Niklas Fahl on 12/19/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Scroll menu setup
        
        // Initialize view controllers to display and place in array
        
        var controllerArray : [UIViewController] = []
        
        let controller1 : RecentViewController = RecentViewController(nibName: "RecentViewController", bundle: nil)
        controller1.title = "Recent"
        controllerArray.append(controller1)
        let controller2 : PopularViewController = PopularViewController(nibName: "PopularViewController", bundle: nil)
        controller2.title = "Popular"
        controllerArray.append(controller2)
        let controller3 : BestViewController = BestViewController(nibName: "BestViewController", bundle: nil)
        controller3.title = "Best"
        controllerArray.append(controller3)
        let controller4 : LocalViewController = LocalViewController(nibName: "LocalViewController", bundle: nil)
        controller4.title = "Local"
        controllerArray.append(controller4)
        
        // Customize menu (Optional)
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
            .ViewBackgroundColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor.orangeColor()),
            .BottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .MenuHeight(40.0),
            .MenuItemWidth(65.0),
            .CenterMenuItems(true)
        ]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }

}


