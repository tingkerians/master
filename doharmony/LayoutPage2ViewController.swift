//
//  LayoutPage2.swift
//  doharmony
//
//  Created by eleazer on 01/02/2016.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class LayoutPage2ViewController: UIViewController {
    
    @IBOutlet var LayoutSelectionView: UIView!
    
    var Template:UIView!
    var Frames = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTemplateTapAction()
        
    }
    
    func addTemplateTapAction(){
        for temp:UIView in LayoutSelectionView.subviews{
            let tap = UITapGestureRecognizer(target: self, action: Selector("next:"))
            temp.addGestureRecognizer(tap)
        }
    }
    
    func next(sender: UITapGestureRecognizer){
        Template = sender.view
        for subview:UIView in Template.subviews{
            Frames.append(subview)
        }
        self.performSegueWithIdentifier("toRecordingPage", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toRecordingPage" {
            let editPage = segue.destinationViewController as! Recording2ViewController
            editPage.dupe(Template)
        }
    }
}