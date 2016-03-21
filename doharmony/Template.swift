


import UIKit
import AVFoundation

class TemplateController{

    let db = RecordingData()
    var Layout:UIView!
    var Frames:[UIView] = []
    var playerLayers:[AVPlayerLayer] = []
    var frameButtons:[UIView] = []
    var duration:CMTime = kCMTimeZero
    var delegate:AnyObject!
    
    init(layout:UIView, defaultLayout:UIView){
        Layout = layout
        playerLayers = []
        frameButtons = []
        let fetchTemplate = db.fetch("Layout", predicate: NSPredicate(format: "isSubview == %@", false))
        if fetchTemplate.count>0{
            print("use selected layout")
            let template = fetchTemplate[0]
            let W = template.valueForKey("width") as! CGFloat
            let H = template.valueForKey("height") as! CGFloat
            
            let fetchSubviews = db.fetch("Layout", predicate: NSPredicate(format: "isSubview == %@", true))
            var index = 0
            for subview in fetchSubviews{
                var x = subview.valueForKey("x") as! CGFloat  * (Layout.bounds.width/W)
                var y = subview.valueForKey("y") as! CGFloat * (Layout.bounds.height/H)
                var w = subview.valueForKey("width") as! CGFloat * (Layout.bounds.width/W)
                var h = subview.valueForKey("height") as! CGFloat * (Layout.bounds.height/H)
                
                x-=2;y-=2;w+=4;h+=4;
                
                let frame = UIView(frame: CGRectMake(x,y,w,h))
                frame.backgroundColor = UIColor.blackColor()
                initFrameArrays(frame, tag: index)
                Layout.addSubview(frame)
                index++
            }
        }else{
            print("use default layout")
            setDefault(defaultLayout)
        }
    }
    
    func setDefault(layout:UIView){
        let W = layout.frame.width
        let H = layout.frame.height
        var index = 0
        for var subview in layout.subviews {
            var x = subview.frame.origin.x * (Layout.bounds.width/W)
            var y = subview.frame.origin.y * (Layout.bounds.height/H)
            var w = subview.frame.width * (Layout.bounds.width/W)
            var h = subview.frame.height * (Layout.bounds.height/H)
            x-=2;y-=2;w+=4;h+=4;
            subview = UIView(frame: CGRectMake(x,y,w,h))
            initFrameArrays(subview, tag: index)
            index++
        }
    }
    
    func initFrameArrays(frame:UIView, tag:Int){
        frame.backgroundColor = UIColor.blackColor()
        frame.tag = tag
        playerLayers.append(AVPlayerLayer())
        frameButtons.append(UIView())
        Frames.append(frame)
        Layout.addSubview(frame)
    }
    
    func refreshFrames(){
        for var index = 0; index<Frames.count; index++ {
            clearFrame(Frames[index])
            let filter = NSPredicate(format: "tag = %@", NSNumber(integer:index))
            let data = db.fetch("Recordings", predicate: filter)
            var frameHasVideo = false
            var player = AVPlayer()
            
            if data.count>0{
                let filename = data[0].valueForKey("record") as! String
                let path = env.documentFolder.stringByAppendingPathComponent("/\(filename)")
                let url = NSURL(fileURLWithPath: path)
                let testAsset = AVAsset(URL: url)
                
                if NSFileManager.defaultManager().fileExistsAtPath(path) {
                    if testAsset.duration > self.duration{
                        self.duration = testAsset.duration
                    }
                    player = AVPlayer(URL: url)
                    frameHasVideo = true
                    
                }
            }
            
            playerLayers[index].player = player
            playerLayers[index].videoGravity = AVLayerVideoGravityResizeAspectFill
            playerLayers[index].frame = Frames[index].bounds
            Frames[index].layer.addSublayer(playerLayers[index])
            
            setButtonsForView(Frames[index], frameHasVideo: frameHasVideo)
        }
    }
    
    func setButtonsForView(sender:UIView, frameHasVideo:Bool){
        let tag = sender.tag
        
        let recordImage = UIImage(named: "recording") as UIImage!
        let importImage = UIImage(named: "import") as UIImage!
        let inviteImage = UIImage(named: "invite") as UIImage!
        let afxImage = UIImage(named: "audioeffect") as UIImage!
        
        let btnWidth = UIScreen.mainScreen().bounds.width/12
        let btnHeight = UIScreen.mainScreen().bounds.width/12
        let spacer = btnWidth / 3
        
        var btnViewWidth:CGFloat = 0
        var btnViewHeight:CGFloat = 0
        
        let recordButton = UIButton(frame: CGRectMake(btnViewWidth, 0, btnWidth, btnHeight))
        recordButton.setImage(recordImage, forState: .Normal)
        recordButton.addTarget(delegate, action: "recordVideo:", forControlEvents:.TouchUpInside)
        
        btnViewWidth += (btnWidth+spacer)
        btnViewHeight = inviteImage.size.height
        
        let importButton = UIButton(frame: CGRectMake(btnViewWidth, 0, btnWidth, btnHeight))
        importButton.setImage(importImage, forState: .Normal)
        importButton.addTarget(delegate, action: "importVideo:", forControlEvents:.TouchUpInside)
        
        btnViewWidth += (btnWidth+spacer)
        
        let inviteButton = UIButton(frame: CGRectMake(btnViewWidth, 0, btnWidth, btnHeight))
        inviteButton.setImage(inviteImage, forState: .Normal)
        inviteButton.addTarget(delegate, action: "inviteFriend:", forControlEvents:.TouchUpInside)
        
        btnViewWidth += (btnWidth)
        
        let afxButton = UIButton(frame: CGRectMake(0, btnHeight+spacer, btnWidth, btnHeight))
        afxButton.setImage(afxImage, forState: .Normal)
        afxButton.addTarget(delegate, action: "addAudioEffects:", forControlEvents:.TouchUpInside)
        
        if frameHasVideo{
            btnViewHeight += btnHeight+spacer
        }
        
        let size = CGRectMake( 0 , 0 , btnViewWidth, btnViewHeight)
        let buttonsView:UIView = UIView.init(frame: size)
        
        recordButton.tag = tag
        importButton.tag = tag
        inviteButton.tag = tag
        buttonsView.addSubview(inviteButton)
        buttonsView.addSubview(importButton)
        buttonsView.addSubview(recordButton)
        
        if frameHasVideo{
            afxButton.tag = tag
            buttonsView.addSubview(afxButton)
        }
        
        buttonsView.center = UIView.init(frame: sender.bounds).center;
        frameButtons[tag] = buttonsView
        sender.addSubview(frameButtons[tag])
    }
    
    func clearLayout(){
        if Layout != nil {
            for view in Layout.subviews {
                view.removeFromSuperview()
            }
        }
    }
    
    func clearFrame(frame:UIView){
        for view in frame.subviews {
            view.removeFromSuperview()
        }
    }
}