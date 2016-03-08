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
        
        var parameters = env.CAPSPageMenuOptions
        parameters.append(.MenuItemWidth(90.0))
        
        pageMenu = CAPSPageMenu(viewControllers: self.controllerArray, frame: CGRectMake(0.0, 44.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        pageMenu!.didMoveToParentViewController(self)
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
}
