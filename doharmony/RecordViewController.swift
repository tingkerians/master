//
//  RecordViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/18/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController,UITabBarControllerDelegate {

    var pageMenu : CAPSPageMenu?
    let defaultIndex = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.delegate = self
        
        // Initialize view controllers to display and place in array
        
        var controllerArray : [UIViewController] = []
        
        let controller1 : TemplateViewController = TemplateViewController(nibName: "TemplateViewController", bundle: nil)
        controller1.title = locale.Template
        let controller2 : RecordingViewController = RecordingViewController(nibName: "RecordingViewController", bundle: nil)
        controller2.title = locale.Record
        
        controller1.delegate = controller2
        
        controllerArray = [controller1, controller2]
        
        // Initialize scroll menu
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: env.CAPSPageMenuOptions)
        
        controller2.defaultTemplate = controller1.defaultTemplate
        controller1.pageMenu = pageMenu
        
        pageMenu!.scrollAnimationDurationOnMenuItemTap = 0
        pageMenu!.moveToPage(defaultIndex)
        pageMenu!.scrollAnimationDurationOnMenuItemTap = 500
        
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
