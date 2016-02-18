//
//  TemplateViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/18/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class TemplateViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var pageMenu : CAPSPageMenu?
    @IBOutlet var LayoutSelectionView: UIView!

    var Template:UIView!
    var Frames = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        addTemplateTapAction()
        
        let tap = UITapGestureRecognizer(target: self, action: nil)
        tap.delegate = self
        LayoutSelectionView.addGestureRecognizer(tap)

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
       
        let editPage =  RecordingViewController()
        editPage.dupe(Template)
        
//        pageMenu!.moveToPage(1)
        
        
        //        let recordPage: RecordingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RecordingPage") as! RecordingViewController
        //        recordPage.daryl = Template
        //
        //        self.dismissViewControllerAnimated(false, completion: nil)
//        self.dismissViewControllerAnimated(false, completion: { ()  -> Void in
//            let recordPage: Recording2ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RecordingPage") as! Recording2ViewController
//            recordPage.daryl = self.Template
//            self.presentViewController(recordPage, animated: true, completion: nil)
//        })
        //        self.performSegueWithIdentifier("toRecordingPage", sender: sender)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

}
