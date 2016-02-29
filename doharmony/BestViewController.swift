//
//  BestViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/24/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class BestViewController: UIViewController, UISearchBarDelegate  {

    var pageMenu : CAPSPageMenu?
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var controllerArray : [UIViewController] = []
    var parameters: [CAPSPageMenuOption]?
    
    var controller1 : PopularBestTableViewController?
    var controller2 : PopularBestTableViewController?
    var controller3 : PopularBestTableViewController?
    
    override func viewDidLoad() {
        self.controller1 = PopularBestTableViewController(nibName: "PopularBestTableViewController", bundle: nil)
        self.controller1!.title = "Last Week"
        self.controller1!.category = "best"
        self.controller1!.date = "week"
        controllerArray.append(self.controller1!)
        
        self.controller2 = PopularBestTableViewController(nibName: "PopularBestTableViewController", bundle: nil)
        self.controller2!.title = "Last Month"
        self.controller2!.category = "best"
        self.controller2!.date = "month"
        controllerArray.append(self.controller2!)
        
        
        self.controller3 = PopularBestTableViewController(nibName: "PopularBestTableViewController", bundle: nil)
        self.controller3!.title = "All Time"
        self.controller3!.category = "best"
        self.controller3!.date = "all"
        self.controllerArray.append(self.controller3!)
        
        // Customize menu (Optional)
        self.parameters = [
            .ScrollMenuBackgroundColor(UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
            .ViewBackgroundColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
            .SelectionIndicatorColor(UIColor.orangeColor()),
            .BottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .MenuHeight(40.0),
            .MenuItemWidth(90.0),
            .CenterMenuItems(true)
        ]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        pageMenu = CAPSPageMenu(viewControllers: self.controllerArray, frame: CGRectMake(0.0, 44.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: self.parameters)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMoveToParentViewController(self)
    }

    //search delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.controller1!.search(searchText)
        self.controller2!.search(searchText)
        self.controller3!.search(searchText)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
