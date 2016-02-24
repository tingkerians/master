//
//  LocalViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/24/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import CoreData

class LocalViewController: UIViewController, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var coreData = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.registerNib(UINib(nibName: "LocalTableViewCell", bundle: nil), forCellReuseIdentifier: "LocalTableViewCell")
//        let _ = test()
        fetchCoreData(nil)
    }
    
    func fetchCoreData(filter: NSPredicate?){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
       
        let fetchRequest = NSFetchRequest(entityName: "Tracks")
        fetchRequest.predicate = filter
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            coreData = results as! [NSManagedObject]
        } catch{
            print("error3")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //scroll delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    //table delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return coreData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : LocalTableViewCell = tableView.dequeueReusableCellWithIdentifier("LocalTableViewCell") as! LocalTableViewCell
        
        cell.TitleLabel.text = coreData[indexPath.row].valueForKey("trackname") as? String
        cell.authorLabel.text = coreData[indexPath.row].valueForKey("username") as? String
        cell.ImageView.image = UIImage(named: (coreData[indexPath.row].valueForKey("trackimage") as? String)!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = TrackDetailsViewController(nibName: "TrackDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
        
        
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }
    
    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRowAtIndexPath(indexPath)
        cell!.contentView.backgroundColor = .clearColor()
    }

    //search delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        let filter: NSPredicate?
        if(searchText.isEmpty){
            filter = nil
        }else{
            filter = NSPredicate(format: "ANY trackname CONTAINS[c] %@", searchText)
        }
        
        fetchCoreData(filter)
        tableView.reloadData()
        
    }
    
    
}
