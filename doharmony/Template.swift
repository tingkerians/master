


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
    
    init(){
        let result = db.fetch("Layout", predicate: nil)
        if result.count > 0 {
            var index = 0
            for item in result{
                let x = item.valueForKey("x") as! CGFloat * 3.3
                let y = item.valueForKey("y") as! CGFloat * 3.3
                let width = item.valueForKey("width") as! CGFloat * 3.3
                let height = item.valueForKey("height") as! CGFloat * 3.3
                let isSubview = item.valueForKey("isSubview") as! Bool
                
                let view = UIView(frame: CGRectMake(x, y, width, height))
                
                if(isSubview){
                    initFrameArrays(view, tag: index)
                    index++
                }else{
                    view.backgroundColor = UIColor.lightGrayColor()
                    let screenSize: CGRect = UIScreen.mainScreen().bounds
                    let posX = (screenSize.width/2) - (width/2)
                    let posY = CGFloat(0)
                    view.frame.origin.x = posX
                    view.frame.origin.y = posY
                    Layout = view
                }
            }
        }else{
            Layout = nil
        }
    }
    
    func setLayout(layout:UIView){
        let W = layout.frame.width * 7
        let H = layout.frame.height * 7
        Layout = UIView(frame: CGRectMake(0,0,W,H))
        Layout.backgroundColor = UIColor.lightGrayColor()
        var index = 0
        for subview in layout.subviews {
            let x = subview.frame.origin.x * 7 - 5.5
            let y = subview.frame.origin.y * 7 - 5.5
            let w = subview.frame.width * 7 + 11
            let h = subview.frame.height * 7 + 11
            let frame = UIView(frame: CGRectMake(x,y,w,h))
            initFrameArrays(frame, tag: index)
            index++
        }
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let posX = (screenSize.width/2) - (W/2)
        let posY = CGFloat(0)
        Layout.frame.origin.x = posX
        Layout.frame.origin.y = posY
    }
    
    func initFrameArrays(frame:UIView, tag:Int){
        frame.backgroundColor = UIColor.blackColor()
        frame.tag = tag
        playerLayers.append(AVPlayerLayer(player:AVPlayer()))
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
                let path = data[0].valueForKey("path") as! String
                let url = NSURL(string: path)!
                let testAsset = AVAsset(URL: url)
                if testAsset.tracksWithMediaType(AVMediaTypeVideo).count > 0{
                    if testAsset.duration > duration{
                        duration = testAsset.duration
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
        let btnWidth = inviteImage.size.width - 10
        let btnHeight = inviteImage.size.height - 10
        var btnViewWidth:CGFloat = 0
        var btnViewHeight:CGFloat = 0
        
        let recordButton = UIButton(frame: CGRectMake(btnViewWidth, 0, btnWidth, btnHeight))
        recordButton.setImage(recordImage, forState: .Normal)
        recordButton.addTarget(delegate, action: "recordVideo:", forControlEvents:.TouchUpInside)
        
        btnViewWidth += (inviteImage.size.width+20)
        btnViewHeight = inviteImage.size.height
        
        let importButton = UIButton(frame: CGRectMake(btnViewWidth, 0, btnWidth, btnHeight))
        importButton.setImage(importImage, forState: .Normal)
        importButton.addTarget(delegate, action: "importVideo:", forControlEvents:.TouchUpInside)
        
        btnViewWidth += (inviteImage.size.width+20)
        
        let inviteButton = UIButton(frame: CGRectMake(btnViewWidth, 0, btnWidth, btnHeight))
        inviteButton.setImage(inviteImage, forState: .Normal)
        inviteButton.addTarget(delegate, action: "inviteFriend:", forControlEvents:.TouchUpInside)
        
        btnViewWidth += (btnWidth)
        
        let afxButton = UIButton(frame: CGRectMake(0, inviteImage.size.height+5, btnWidth, btnHeight))
        afxButton.setImage(afxImage, forState: .Normal)
        afxButton.addTarget(delegate, action: "addAudioEffects:", forControlEvents:.TouchUpInside)
        
        if frameHasVideo{
            btnViewHeight += inviteImage.size.height+20
        }
        
        let size = CGRectMake( 10 , 10 , btnViewWidth, btnViewHeight)
        let buttonsView:UIView = UIView.init(frame: size)
        
        recordButton.tag = tag
        importButton.tag = tag
        inviteButton.tag = tag
        buttonsView.addSubview(inviteButton)
        buttonsView.addSubview(importButton)
        buttonsView.addSubview(recordButton)
        
        if frameHasVideo{
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