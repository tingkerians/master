//
//  BestViewController.swift
//  doharmony
//
//  Created by Mark Bermillo on 23/02/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BestViewController: UIViewController {
  
    var pageMenu : CAPSPageMenu?
    // Variable to hold the `best tracks` from the server
    var trackList: [JSON] = [];
    // Server URL for getting `best tracks`
    let url = "http://192.168.0.137:8080/api/best";

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("fetching `best tracks` data");

        Alamofire.request(.GET, url, parameters: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let result = JSON(response.result.value!);
                    
                    // Initialize view controllers to display and place in array
                    
                    var controllerArray : [UIViewController] = []
                    
                    let controller1 : BestCategoryTableViewController = BestCategoryTableViewController(nibName: "BestCategoryTableViewController", bundle: nil);
                    controller1.title = "Last Week";
                    if let week = result["last_week"][0]["data"].arrayValue as [JSON]?{
                        controller1.trackList = week;
                    }
                    controllerArray.append(controller1);
                    
                    let controller2 : BestCategoryTableViewController = BestCategoryTableViewController(nibName: "BestCategoryTableViewController", bundle: nil)
                    controller2.title = "Last Month"
                    if let month = result["last_month"][0]["data"].arrayValue as [JSON]?{
                        controller2.trackList = month;
                    }
                    controllerArray.append(controller2)
                    
                    let controller3 : BestCategoryTableViewController = BestCategoryTableViewController(nibName: "BestCategoryTableViewController", bundle: nil)
                    controller3.title = "All Time"
                    if let all = result["all_time"][0]["data"].arrayValue as [JSON]?{
                        controller3.trackList = all;
                    }
                    controllerArray.append(controller3)
                    
                    // Customize menu (Optional)
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
                    self.pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
                    
                    self.addChildViewController(self.pageMenu!)
                    self.view.addSubview(self.pageMenu!.view)
                    
                    self.pageMenu!.didMoveToParentViewController(self)
                    
                case .Failure(let error):
                    print("HTTP RESPONSE:\n\(response.response)");
                    self.showAlert("Fetch data failed", message: String(error.localizedDescription));
                }
        }

    }
    
        /*
        Used to show alerts and message
        */
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title,
                message: message, preferredStyle: .Alert);
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil);
            
            alert.addAction(action);
            
            self.presentViewController(alert, animated: true, completion: nil);
            return;
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
