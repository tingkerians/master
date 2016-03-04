//
//  RecordingViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/18/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import AVFoundation
import CoreData

class RecordingViewController: UIViewController, AVCaptureFileOutputRecordingDelegate, TemplateViewControllerDelegate, timerControllerCountdownDelegate, timerControllerStopTimerDelegate, timerControllerDurationTimerDelegate{
    
    @IBOutlet weak var layoutDisplay: UIView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var playButton: UIButton!
    var defaultTemplate:UIView!
    
    let stopRecordButton = UIButton(type: UIButtonType.System)
    
    let db = RecordingData()
    var Template:TemplateController!
    let Capture = captureController()
    let Cropper = Crop()
    
    var isPlaying = false
    var isRecording = false
    
    let Countdown = timerController()
    let PlayerTimer = timerController()
    let DurationTimer = timerController()
    
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var seconds: UILabel!
    
    var filename:String!
    var framePointer = 0
    
    
    //VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        useTemplate()
    }
        
    //TEMPLATE
    func useTemplate(){
        for view in container.subviews{
            view.removeFromSuperview()
        }
        Template = TemplateController(layout:container,defaultLayout: defaultTemplate)
        Template.delegate = self
        Template.refreshFrames()
    }
    
    
    //RECORD
    @IBAction func changeCamera(sender: AnyObject) {
        if Capture.captureSession.running && isRecording == false{
            Capture.changeCamera()
        }
    }
    func recordVideo(sender:UIButton){
        if Capture.captureSession.running == false{
            if isPlaying{
                stopAll()
            }
            framePointer = sender.tag
            print("tag",framePointer)
            let frame = Template.Frames[framePointer]
            Capture.setCaptureLayer(frame)
            Capture.captureSession.startRunning()
            
            Countdown.setupCountdown(5, frame: frame, delegate: self)
            Countdown.start()
        }
    }
    
    func countdownExpires() {
        filename = randomStringWithLength(5) as String
        Capture.start(self, filename:filename)
        
        playButton.hidden = true
        stopRecordButton.frame = playButton.bounds
        stopRecordButton.frame.origin.x = playButton.frame.origin.x
        stopRecordButton.frame.origin.y = playButton.frame.origin.y
        stopRecordButton.setImage(UIImage(named: "stop"), forState: .Normal) //image
        stopRecordButton.tintColor = .whiteColor()
        stopRecordButton.addTarget(self, action: "stopRecord", forControlEvents:.TouchUpInside)
        self.view.addSubview(stopRecordButton)
        stopRecordButton.hidden = false
    }
    
    func stopRecord(){
        Capture.stop()
    }
    
    func importVideo(sender:UIButton){
        print("import video")
        let Local = ImportViewController()
        self.presentViewController(Local, animated: true, completion: nil)
    }
    func inviteFriend(sender:UIButton){
        print("invite friend")
    }
    func addAudioEffects(sender:UIButton){
        print("add audio effects")
    }
    
    //PLAYBACK
    @IBAction func playVideo(sender: AnyObject) {
        playAll()
    }
    func playAll(){
        var duration = CMTimeGetSeconds(Template.duration)
        duration = Double(round(10*duration)/10)
        for layer in Template.playerLayers{
            layer.player?.seekToTime(kCMTimeZero)
            layer.player?.play()
        }
        if duration != 0.0 || Capture.captureSession.running  == true{
            DurationTimer.setupDurationTimer(self)
            DurationTimer.start()
            for btnView in Template.frameButtons{
                btnView.hidden = true
            }
        }
        //stopper
        if duration != 0.0 && Capture.captureSession.running == false{
            let stopTimer = timerController()
            stopTimer.setupStopTimer(duration, delegate: self)
            stopTimer.start()
        }
        isPlaying = true
    }
    func stopAll(){
        isPlaying = false
        for layer:AVPlayerLayer in Template.playerLayers{
            layer.player?.seekToTime(kCMTimeZero)
            layer.player?.pause()
        }
        DurationTimer.stop()
        for btnView in Template.frameButtons{
            btnView.hidden = false
        }
    }
    
    //timer delegates
    func timeUpdate(h: Int, m: Int, s: Int) {
        var mstring = "\(m)"
        var sstring = "\(s)"
        if s<10 {
            sstring = "0\(s)"
        }
        if m<10 {
            mstring = "0\(m)"
        }
        minutes.text = mstring
        seconds.text = sstring
    }
    func stopTimerExpires() {
        stopAll()
    }
    
    //CAPTURE DELEGATES
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
        NSLog("recording started")
        isRecording = true
        
        playAll()
    }
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        NSLog("recording Finished")
        isRecording = false
        
//        let croppedVideo = Cropper.crop(outputFileURL, frame: Frame, captureLayer: Capture.layer, filename: filename).path!
        
        let filter = NSPredicate(format: "tag == %@", NSNumber(integer: framePointer))
        let currentFrameVid = db.fetch("Recordings", predicate: filter)
        let recordingPath = NSString(string: outputFileURL.absoluteString)
        if currentFrameVid.count>0{
            db.update("Recordings", predicate: filter, value: nil, key: "tag")
        }
        db.insert("Recordings", values: ["tag":framePointer , "path":recordingPath])
        
        Capture.layer.removeFromSuperlayer()
        self.stopRecordButton.hidden = true
        self.playButton.hidden = false
        Template.refreshFrames()
        
        stopAll()
        playAll()
    }
    
    func randomStringWithLength (len : Int) -> NSString {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString : NSMutableString = NSMutableString(capacity: len)
        for (var i=0; i < len; i++){
            let length = UInt32 (letters.length)
            let rand = arc4random_uniform(length)
            randomString.appendFormat("%C", letters.characterAtIndex(Int(rand)))
        }
        return randomString
    }

}
