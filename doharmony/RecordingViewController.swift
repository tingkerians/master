//
//  RecordingViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/18/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class RecordingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlayButton(sender: AnyObject) {
        print("Play")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
