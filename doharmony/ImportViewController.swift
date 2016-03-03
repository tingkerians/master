//
//  LocalViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/24/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation


class ImportViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let records = localRecordings()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "LocalTableViewCell", bundle: nil), forCellReuseIdentifier: "LocalTableViewCell")
    }
    
    @IBAction func closeWindow(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.paths.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : LocalTableViewCell = tableView.dequeueReusableCellWithIdentifier("LocalTableViewCell") as! LocalTableViewCell
        
//        let trackExist:Bool = AVAsset(URL: NSURL(fileURLWithPath: records.paths[indexPath.row])).tracksWithMediaType(AVMediaTypeVideo).count > 0
//        if trackExist{
            cell.ImageView.image = UIImage(named: "badge1")
            cell.textLabel?.text = records.paths[indexPath.row]
//        }
        return cell
    }
    
}
