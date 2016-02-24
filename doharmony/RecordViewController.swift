//
//  RecordViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/18/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    var pageMenu : CAPSPageMenu?
    let defaultIndex = 1
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        
        // MARK: - UI Setup
//        self.title = "PAGE MENU"
//        self.navigationController?.navigationBar.barTintColor = UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
//        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "<-", style: UIBarButtonItemStyle.Done, target: self, action: "didTapGoToLeft")
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "->", style: UIBarButtonItemStyle.Done, target: self, action: "didTapGoToRight")

        // MARK: - Scroll menu setup
        
        // Initialize view controllers to display and place in array
        var controllerArray : [UIViewController] = []
        
        let controller1 : TemplateViewController = TemplateViewController(nibName: "TemplateViewController", bundle: nil)
        controller1.title = "Templates"
        controllerArray.append(controller1)
        let controller2 : RecordingViewController = RecordingViewController(nibName: "RecordingViewController", bundle: nil)
        controller2.title = "Record"
        controllerArray.append(controller2)
        let controller3 : PopularTableViewController = PopularTableViewController(nibName: "PopularTableViewController", bundle: nil)
        controller3.title = "Local"
        controllerArray.append(controller3)

        
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

        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMoveToParentViewController(self)
        
        pageMenu!.scrollAnimationDurationOnMenuItemTap = 0
        pageMenu!.moveToPage(defaultIndex)
        pageMenu!.scrollAnimationDurationOnMenuItemTap = 500
    }
    
//    func didTapGoToLeft() {
////        currentIndex = pageMenu!.currentPageIndex
//        print(pageMenu!.currentPageIndex)
//        if currentIndex > 0 {
//            pageMenu!.moveToPage(currentIndex - 1)
//        }
//    }
//    
//    func didTapGoToRight() {
////        currentIndex = pageMenu!.currentPageIndex
//        print("current page: \(currentIndex)")
//        
//        if currentIndex < pageMenu!.controllerArray.count {
//            pageMenu!.moveToPage(currentIndex + 1)
//        }
//    }
//    
//    // MARK: - Container View Controller
//    override func shouldAutomaticallyForwardAppearanceMethods() -> Bool {
//        return true
//    }
//    
//    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
//        return true
//    }
}
