//
//  ViewController.swift
//  PageMenuDemoStoryboard
//
//  Created by Niklas Fahl on 12/19/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewControllerProtectedPage,UITabBarControllerDelegate {
    
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        
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
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        let selectedIndex = tabBarController.viewControllers?.indexOf(viewController)
        tabBarTransition.selectedIndex = selectedIndex
        tabBarTransition.prevSelectedIndex = tabBarController.selectedIndex
        
        return true
    }
}


