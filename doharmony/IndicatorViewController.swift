//
//  IndicatorViewController.swift
//  doharmony
//
//  Created by eliakim on 3/4/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class IndicatorViewController: UIViewController {
    
    @IBOutlet weak var AI: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AI.startAnimating()
        // Do any additional setup after loading the view.
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
