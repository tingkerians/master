//
//  RecordingViewController.swift
//  doharmony
//
//  Created by eleazer on 31/01/2016.
//  Copyright © 2016 khemer sone andres. All rights reserved.
//

import UIKit

class Recording2ViewController: UIViewController {
   
    @IBAction func playButton(sender: AnyObject) {
        print("Play")
    }
    
    var daryl : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        defaultTemplate()
        
        if daryl == nil {
//            print("wala")
        } else {
            dupe(daryl)
            print("daryl: \(daryl.frame.width)")
        }
        
    }

    
    func dupe(template:UIView){
        
        print("Dup \(template.frame.width)")
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        //let height = bounds.size.height
//        print("screen width: \(width)")
//        print("screen height: \(height)")
        
        let templateWidth = template.frame.width * 3 - 10
        let templateHeight = template.frame.height * 3 - 10
        let leftMargin = (width - templateWidth) / 2
//        print("template width: \(templateWidth)")
//        print("template height: \(templateHeight)")
//        print("template margin: \(width - templateWidth)")
        
        let newTemplate = UIView.init(frame: CGRectMake( leftMargin , 80, templateWidth , templateHeight))
            newTemplate.backgroundColor = UIColor.whiteColor()
            newTemplate.contentMode = .ScaleAspectFit
//            print(template.frame.width)
//            print(template.frame.height)
        
            self.view.addSubview(newTemplate)

        
        for sv:UIView in template.subviews{
            print("frames \(sv.frame.width)")
            let x = sv.frame.origin.x * 3 - 10
            let y = sv.frame.origin.y * 3 - 10
            let w = sv.frame.width * 3 + 10
            let h = sv.frame.height * 3 + 10
            
            let size = CGRectMake(x, y, w, h)
            let frame:UIView = UIView.init(frame: size)
            frame.backgroundColor = UIColor.darkGrayColor()
            newTemplate.addSubview(frame)
            frame.addSubview(buttonsView(frame,w: h,h: h))
        }
        
        
    }
    
    
    func defaultTemplate() {
        let bounds = UIScreen.mainScreen().bounds
        let width = bounds.size.width
        let height = bounds.size.height
        let Margin : CGFloat = 40.0
        let leftMargin : CGFloat = Margin / 2
        let templateWidth = width - Margin
        print("Screen Width: \(width)")
        print("Screen Height: \(height)")
        print("leftmargin: \(leftMargin)")
        print("Template Width: \(templateWidth)")
        
        let xdefaultTemplate : CGFloat = leftMargin
        let ydefaultTemplate : CGFloat = 80
        let wdefaultTemplate : CGFloat = templateWidth
        let hdefaultTemplate : CGFloat = templateWidth
        let defaultTemplate = UIView.init(frame: CGRectMake( xdefaultTemplate, ydefaultTemplate, wdefaultTemplate , hdefaultTemplate))
        defaultTemplate.backgroundColor = UIColor.whiteColor()
        defaultTemplate.contentMode = .ScaleAspectFit
        self.view.addSubview(defaultTemplate)
        
        let xframe1 : CGFloat = 2
        let yframe1 : CGFloat = 2
        let wframe1 : CGFloat = 292
        let hframe1 : CGFloat = 604
        let frame1:UIView = UIView.init(frame: CGRectMake( xframe1 , yframe1, wframe1, hframe1))
        frame1.backgroundColor = UIColor.darkGrayColor()
        //let horizontalConstraint = NSLayoutConstraint(item: defaultTemplate, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
//        frame1.addConstraint(horizontalConstraint)
        defaultTemplate.addSubview(frame1)
        
        let xframe2 : CGFloat = 296
        let yframe2 : CGFloat = 296
        let wframe2 : CGFloat = 310
        let hframe2 : CGFloat = 310
        let frame2:UIView = UIView.init(frame: CGRectMake( xframe2 , yframe2, wframe2, hframe2))
        frame2.backgroundColor = UIColor.darkGrayColor()
        defaultTemplate.addSubview(frame2)
        
        let xframe3 : CGFloat = 296
        let yframe3 : CGFloat = 2
        let wframe3 : CGFloat = 310
        let hframe3 : CGFloat = 292
        let frame3:UIView = UIView.init(frame: CGRectMake(xframe3 , yframe3, wframe3, hframe3))
        frame3.backgroundColor = UIColor.darkGrayColor()
        defaultTemplate.addSubview(frame3)
        
        frame1.addSubview(buttonsView(frame1,w: wframe1,h: hframe1))
        frame2.addSubview(buttonsView(frame2,w: wframe2,h: hframe2))
        frame3.addSubview(buttonsView(frame3,w: wframe3,h: hframe3))
        
        
        
//        let verticalConstraint = NSLayoutConstraint(item: frame1, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
//        defaultTemplate.addConstraint(verticalConstraint)

        
    }
    
    
    func buttonsView(frame:UIView,w:CGFloat,h:CGFloat) -> UIView {
        let xButtonsView = w / 3.2
        let yButtonsView = h / 2
//        print("wframe: \(w)")
//        print("xButtonsView: \(xButtonsView)")
        
        let size = CGRectMake( xButtonsView , yButtonsView , w * 0.4, 50)
        let buttonsView:UIView = UIView.init(frame: size)
        
        let rec = UIImage(named: "recording") as UIImage?
        let recButton   = UIButton(type: UIButtonType.System) as UIButton
        recButton.frame = CGRectMake(6, 4, 20, 16)
        recButton.setImage(rec, forState: .Normal)
        recButton.tintColor = UIColor.whiteColor()
        recButton.addTarget(self, action: "recordBtnTouched:", forControlEvents:.TouchUpInside)
        buttonsView.addSubview(recButton)
        
        let importImage = UIImage(named: "import") as UIImage?
        let importButton   = UIButton(type: UIButtonType.System) as UIButton
        importButton.frame = CGRectMake(35, 4, 20, 20)
        importButton.setImage(importImage, forState: .Normal)
        importButton.tintColor = UIColor.whiteColor()
        importButton.addTarget(self, action: "importBtnTouched:", forControlEvents:.TouchUpInside)
        buttonsView.addSubview(importButton)
        
        let inviteImage = UIImage(named: "invite") as UIImage?
        let inviteButton   = UIButton(type: UIButtonType.System) as UIButton
        inviteButton.frame = CGRectMake(60, 4, 20, 20)
        inviteButton.setImage(inviteImage, forState: .Normal)
        inviteButton.tintColor = UIColor.whiteColor()
        inviteButton.addTarget(self, action: "inviteBtnTouched:", forControlEvents:.TouchUpInside)
        buttonsView.addSubview(inviteButton)
        
//        buttonsView.center = frame.center
        return buttonsView
        
    }
    
    func recordBtnTouched(sender: UIButton!) {
        print("record")
    }
    
    func importBtnTouched(sender: UIButton!) {
        print("import")
    }
    
    func inviteBtnTouched(sender: UIButton!) {
        print("invite")
    }

    
    @IBAction func closeButton(sender: AnyObject) {
         self.tabBarController?.selectedIndex = 0
    }
   
    

}
