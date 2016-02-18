//
//  LayoutViewController.swift
//  doharmony
//
//  Created by eleazer on 28/01/2016.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class LayoutPage1ViewController: UIViewController, UIGestureRecognizerDelegate {

    
    @IBOutlet var LayoutSelectionView: UIView!
    
    
    var Template:UIView!
    var Frames = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
//        let editPage =  RecordingViewController()
//        editPage.dupe(Template)
//        let recordPage: RecordingViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RecordingPage") as! RecordingViewController
//        recordPage.daryl = Template
//
//        self.dismissViewControllerAnimated(false, completion: nil)
        self.dismissViewControllerAnimated(false, completion: { ()  -> Void in
            let recordPage: Recording2ViewController = self.storyboard?.instantiateViewControllerWithIdentifier("RecordingPage") as! Recording2ViewController
            recordPage.daryl = self.Template
            self.presentViewController(recordPage, animated: true, completion: nil)
        })
//        self.performSegueWithIdentifier("toRecordingPage", sender: sender)
    }

  
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print("Preparing for segue")
//        if segue.identifier == "toRecordingPage" {
//            let editPage = segue.destinationViewController as! RecordingViewController
//            editPage.dupe(Template)
//            
//        }
////        self.dismissViewControllerAnimated(false, completion: nil)
//    }
    

}
    
    
    
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
    
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
//        var template: UIView
//        template = UIView.init(frame: CGRectMake(10, 10, 50, 50)) 
//        template.backgroundColor = UIColor.redColor()
//        self.view.addSubview(template)
//        
//        return cell
//    }




//    ///////
//    var Template:UIView!
//    var Frames = [UIView]()
//    var newTemplate:UIView!
//    override func viewDidLoad() {
//        dupe()
//    }
//
//    func dupe(){
//        if(newTemplate !== nil){
//            newTemplate.removeFromSuperview()
//        }
//        newTemplate = UIView.init(frame: CGRectMake(10, 10, Template.frame.width * 2, Template.frame.height * 2))
//        newTemplate.backgroundColor = UIColor.blackColor()
//        self.view.addSubview(newTemplate)
//        newTemplate.center = self.view.center
//        //
//        for(var index = 0 ; index < Frames.count ; index++){
//            let x = Frames[index].frame.origin.x * 2
//            let y = Frames[index].frame.origin.y * 2
//            let w = Frames[index].frame.width * 2
//            let h = Frames[index].frame.height * 2
//
//            let size = CGRectMake(x, y, w, h)
//            let frame:UIView = UIView.init(frame: size)
//            frame.backgroundColor = UIColor.whiteColor()
//
//            newTemplate.addSubview(frame)
//        }
//    }
//
//    ///////////
