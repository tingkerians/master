//
//  ViewController.swift
//  PageMenuDemoStoryboard
//
//  Created by Niklas Fahl on 12/19/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Scroll menu setup
        
        // Initialize view controllers to display and place in array
        
        var controllerArray : [UIViewController] = []
        
        let controller1 : PostsTableViewController = PostsTableViewController(nibName: "PostsTableViewController", bundle: nil)
        controller1.title = locale.Post
        controllerArray.append(controller1)
        let controller2 : MyFriendsTableViewController = MyFriendsTableViewController(nibName: "MyFriendsTableViewController", bundle: nil)
        controller2.title = locale.Friend
        controllerArray.append(controller2)
        let controller3 : FollowingsTableViewController = FollowingsTableViewController(nibName: "FollowingsTableViewController", bundle: nil)
        controller3.title = locale.Following
        controllerArray.append(controller3)
        let controller4 : AllMembersTableViewController = AllMembersTableViewController(nibName: "AllMembersTableViewController", bundle: nil)
        controller4.title = locale.All
        controllerArray.append(controller4)
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: env.CAPSPageMenuOptions)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
}


