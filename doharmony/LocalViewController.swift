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
    
    var data: [Track]?
    var tracks: Tracks?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.tableView.registerNib(UINib(nibName: "LocalTableViewCell", bundle: nil), forCellReuseIdentifier: "LocalTableViewCell")
        let _ = test()
        self.tracks = Tracks()
        self.data = self.tracks!.local()
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
        return self.data!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : LocalTableViewCell = tableView.dequeueReusableCellWithIdentifier("LocalTableViewCell") as! LocalTableViewCell
        
        let tracks = self.data!
        cell.TitleLabel.text = tracks[indexPath.row].title
        cell.authorLabel.text = tracks[indexPath.row].author
        cell.ImageView.image = UIImage(named: (tracks[indexPath.row].imagePath)!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = PlayTrackViewController(nibName: "PlayTrackViewController", bundle: nil)
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
        self.data = self.tracks!.setSearch(searchText).local()
        tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    
}
