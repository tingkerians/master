//
//  LocalViewController.swift
//  doharmony
//
//  Created by eliakim on 2/23/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class LocalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var namesArray : [String] = ["Little Star", "Jingle Bell", "Canon", "Two Tiger", "Bayer No.8", "Silent Night", "The Painter", "Gavotte", "Minuet 1", "Moments"]
    var photoNameArray : [String] = ["littleStar", "jingleBell", "canon", "default", "default", "default", "default", "default", "default", "default"]
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "LocalTableViewCell", bundle: nil), forCellReuseIdentifier: "LocalTableViewCell")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return namesArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : LocalTableViewCell = tableView.dequeueReusableCellWithIdentifier("LocalTableViewCell") as! LocalTableViewCell
        
        cell.TitleLabel.text = namesArray[indexPath.row]
        cell.ImageView.image = UIImage(named: photoNameArray[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50.0
    }
    var valueToPass = "hello world"
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let vc = PlayTrackViewController(nibName: "PlayTrackViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
        
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
