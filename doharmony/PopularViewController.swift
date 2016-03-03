//
//  PopularViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/12/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController, UISearchBarDelegate {

    var pageMenu : CAPSPageMenu?
    var controllerArray : [UIViewController] = []

    
    var controller1 : PopularBestTableViewController?
    var controller2 : PopularBestTableViewController?
    var controller3 : PopularBestTableViewController?
    var tracks: Tracks!
    
    override func viewDidLoad() {
        self.tracks = Tracks.sharedInstance
        
        self.controller1 = PopularBestTableViewController(nibName: "PopularBestTableViewController", bundle: nil)
        self.controller1!.title = locale.ThisWeek
        self.controller1!.category = "popular"
        self.controller1!.date = "week"
        controllerArray.append(self.controller1!)
        
        self.controller2 = PopularBestTableViewController(nibName: "PopularBestTableViewController", bundle: nil)
        self.controller2!.title = locale.ThisMonth
        self.controller2!.category = "popular"
        self.controller2!.date = "month"
        controllerArray.append(self.controller2!)
        
        
        self.controller3 = PopularBestTableViewController(nibName: "PopularBestTableViewController", bundle: nil)
        self.controller3!.title = locale.AllTime
        self.controller3!.category = "popular"
        self.controller3!.date = "all"
        self.controllerArray.append(self.controller3!)
        
        let parameters: [CAPSPageMenuOption] = [
            .ScrollMenuBackgroundColor(UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
            .ViewBackgroundColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor.orangeColor()),
            .BottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .MenuHeight(40.0),
            .MenuItemWidth(90.0),
            .CenterMenuItems(true)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: self.controllerArray, frame: CGRectMake(0.0, 44.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        //pageMenu!.didMoveToParentViewController(self)
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
//    //search delegate
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        self.controller1!.search(searchText)
//        self.controller2!.search(searchText)
//        self.controller3!.search(searchText)
//    }
//    
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        searchBar.endEditing(true)
//    }
}
