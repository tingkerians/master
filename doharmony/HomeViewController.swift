//
//  ViewController.swift
//  PageMenuDemoStoryboard
//
//  Created by Niklas Fahl on 12/19/14.
//  Copyright (c) 2014 CAPS. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController,UISearchBarDelegate {
    
    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let nc = NSNotificationCenter.defaultCenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Scroll menu setup
        
        // Initialize view controllers to display and place in array
        
        var controllerArray : [UIViewController] = []
        
        let controller1 : RecentViewController = RecentViewController(nibName: "RecentViewController", bundle: nil)
        controller1.title = locale.Recent
        controllerArray.append(controller1)
        let controller2 : PopularViewController = PopularViewController()
        controller2.title = locale.Popular
        controllerArray.append(controller2)
        let controller3 : BestViewController = BestViewController()
        controller3.title = locale.Best
        controllerArray.append(controller3)
        let controller4 : LocalViewController = LocalViewController(nibName: "LocalViewController", bundle: nil)
        controller4.title = locale.Local
        controllerArray.append(controller4)
        print(self.view.frame.width)
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: env.CAPSPageMenuOptions)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        self.view.bringSubviewToFront(searchBar)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGesture)
        
//        let spinner = Spinner.sharedInstance
//        spinner.show(self)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tap(gesture: UITapGestureRecognizer) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    //search delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        Tracks.sharedInstance.setSearch(searchText)
        nc.postNotificationName("searchHome", object: searchBar)
    }
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        return true
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
   
}


