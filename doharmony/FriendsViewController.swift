//
//  ViewController.swift
//  PageMenuDemoStoryboard
//
//  Created by Niklas Fahl on 12/19/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewControllerProtectedPage,UITabBarControllerDelegate,CAPSPageMenuDelegate {
    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.hidden = true
        self.tabBarController?.delegate = self
        
        // Initialize view controllers to display and place in array
        
        var controllerArray : [UIViewController] = []
        
        let controller1 : PostsTableViewController = PostsTableViewController(nibName: "PostsTableViewController", bundle: nil)
        controller1.title = locale.Post
        controller1.searchBar = searchBar
        controllerArray.append(controller1)
        let controller2 : MyFriendsTableViewController = MyFriendsTableViewController(nibName: "MyFriendsTableViewController", bundle: nil)
        controller2.title = locale.Friend
        controller2.searchBar = searchBar
        controllerArray.append(controller2)
        let controller3 : FollowingsTableViewController = FollowingsTableViewController(nibName: "FollowingsTableViewController", bundle: nil)
        controller3.title = locale.Following
        controller3.searchBar = searchBar
        controllerArray.append(controller3)
        let controller4 : AllMembersTableViewController = AllMembersTableViewController(nibName: "AllMembersTableViewController", bundle: nil)
        controller4.title = locale.All
        controller4.searchBar = searchBar
        controllerArray.append(controller4)
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: env.CAPSPageMenuOptions)
        pageMenu?.delegate = self
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        self.view.bringSubviewToFront(searchBar)
    }
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        let selectedIndex = tabBarController.viewControllers?.indexOf(viewController)
        tabBarTransition.selectedIndex = selectedIndex
        tabBarTransition.prevSelectedIndex = tabBarController.selectedIndex
        
        return true
    }
    
    func didMoveToPage(controller: UIViewController, index: Int) {
        if(controller.title == locale.Post){
            searchBar.hidden = true
            searchBar.endEditing(true)
        }else{
            searchBar.hidden = false
        }
    }
}


