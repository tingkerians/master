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
    var frameTag:Int = Layout.currentFrame
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "ImportViewTableCell", bundle: nil), forCellReuseIdentifier: "ImportViewTableCell")
    }
    
    @IBAction func closeWindow(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.filenames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : ImportViewTableCell = tableView.dequeueReusableCellWithIdentifier("ImportViewTableCell") as! ImportViewTableCell
        cell.Label.text = records.filenames[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let filename = records.filenames[indexPath.row]
        let recDb = RecordingData()
        let filter = NSPredicate(format: "tag == %@", NSNumber(integer: frameTag))
        if recDb.fetch("Recordings", predicate: filter).count > 0 {
            recDb.update("Recordings", predicate: filter, value: filename, key: "record")
        }else{
            recDb.insert("Recordings", values: ["tag":NSInteger(frameTag),"record":NSString(string: filename)])
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
