//
//  ViewController.swift
//  PageMenuDemoStoryboard
//
//  Created by Niklas Fahl on 12/19/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Scroll menu setup
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        let controller1 : MyProfileViewController = MyProfileViewController(nibName: "MyProfileViewController", bundle: nil)
        controller1.title = locale.Profile
        controllerArray.append(controller1)
        let controller2 : LibrariesTableViewController = LibrariesTableViewController(nibName: "LibrariesTableViewController", bundle: nil)
        controller2.title = locale.Track
        controllerArray.append(controller2)
        let controller3 : LibrariesTableViewController = LibrariesTableViewController(nibName: "LibrariesTableViewController", bundle: nil)
        controller3.title = locale.Project
        controllerArray.append(controller3)

        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: env.CAPSPageMenuOptions)
        
        self.view.addSubview(pageMenu!.view)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

}


