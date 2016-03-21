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

struct Layout{
    static var currentFrame:Int!
}

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
    let MetronomeView = MetronomeViewController()
    
    var isPlaying = false
    var isRecording = false
    
    var metronomeTimer = timerController()
    let Countdown = timerController()
    let PlayerTimer = timerController()
    let DurationTimer = timerController()
    let stopTimer = timerController()
    
    @IBOutlet weak var minutes: UILabel!
    @IBOutlet weak var seconds: UILabel!
    
    var filename:String!
    
    
    //VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        Capture.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
            Layout.currentFrame = sender.tag
            let frame = Template.Frames[Layout.currentFrame]
            
            Template.playerLayers[Layout.currentFrame].player = nil
            
            Capture.setCaptureLayer(frame)
            Capture.captureSession.startRunning()
            
            Countdown.setupCountdown(5, frame: frame, delegate: self)
            Countdown.start()
        }
    }
    
    
    func countdownExpires() {
        filename = randomStringWithLength(5) as String
        Capture.start(filename)
        
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
    
    //METRONOME
    @IBAction func openMetronomeWindow(sender: AnyObject) {
        MetronomeView.timer = metronomeTimer
        self.presentViewController(MetronomeView, animated: true, completion: nil)
    }
    
    //IMPORT
    func importVideo(sender:UIButton){
        print("IMPORT VIDEO")
        Layout.currentFrame = sender.tag
        let Local = ImportViewController()
        self.presentViewController(Local, animated: true, completion: nil)
    }
    
    //INVITE
    func inviteFriend(sender:UIButton){
        print("INVITE FRIEND")
    }
    
    //ADD Audio Effects
    func addAudioEffects(sender:UIButton){
        print("ADD AUDIO EFFECTS")
        Layout.currentFrame = sender.tag
        let AudioEffects = AudioEffectsController()
        self.presentViewController(AudioEffects, animated: true, completion: nil)
    }
    
    //PLAYBACK
    @IBAction func playVideo(sender: AnyObject) {
        if Capture.captureSession.running == false{
            playAll()
        }
    }
    func playAll(){
        minutes.text = "00"; seconds.text = "00"
        if DurationTimer.isRunning {DurationTimer.stop()}
        if stopTimer.isRunning {stopTimer.stop()}
        
        var duration = CMTimeGetSeconds(Template.duration)
        duration = Double(round(10*duration)/10)
        
        if duration > 0.0 {
            for layer in Template.playerLayers{
                layer.player?.seekToTime(kCMTimeZero)
                layer.player?.play()
            }
            DurationTimer.setupDurationTimer(self)
            DurationTimer.start()
            for btnView in Template.frameButtons{
                btnView.hidden = true
            }
            isPlaying = true
            
            if Capture.captureSession.running == false{
                stopTimer.setupStopTimer(duration, delegate: self)
                stopTimer.start()
            }
        }else{
            if Capture.captureSession.running == true{
                DurationTimer.setupDurationTimer(self)
                DurationTimer.start()
                for btnView in Template.frameButtons{
                    btnView.hidden = true
                }
            }
        }
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
        if s<10 {sstring = "0\(s)"}
        if m<10 {mstring = "0\(m)"}
        minutes.text = mstring
        seconds.text = sstring
    }
    func stopTimerExpires() {
        stopAll()
    }
    
    //CAPTURE DELEGATES
    func captureOutput(captureOutput: AVCaptureFileOutput!, didStartRecordingToOutputFileAtURL fileURL: NSURL!, fromConnections connections: [AnyObject]!) {
        NSLog("[RECORD] capture started")
        isRecording = true
        
        if MetronomeView.metronomeSwitch != nil && MetronomeView.metronomeSwitch.on {
            metronomeTimer.start()
        }
        
        playAll()
    }
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        if error != nil {
            print(error)
        }
        isRecording = false
        let recordingFilename = "Recording/\(outputFileURL.lastPathComponent!)"
        
        if MetronomeView.metronomeSwitch != nil && MetronomeView.metronomeSwitch.on {
            metronomeTimer.stop()
        }
        
        NSLog("[RECORD] capture finished -> \(recordingFilename)")
        let filter = NSPredicate(format: "tag == %@", NSNumber(integer: Layout.currentFrame))
        let currentFrameVid = db.fetch("Recordings", predicate: filter)
        if currentFrameVid.count>0{
            db.update("Recordings", predicate: filter, value: nil, key: "tag")
        }
        db.insert("Recordings", values: ["tag":Layout.currentFrame , "record":NSString(string: recordingFilename)])

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

    @IBAction func SAVE(sender: AnyObject) {
        print("SAVE")
//        let Saver = SaveProjectController()
//        Saver.Layout = Template.Layout
//        self.presentViewController(Saver, animated: true, completion: nil)
        
        let vc = SaveProjectController(nibName: "SaveProjectController", bundle: nil);
        vc.Layout = Template.Layout
        self.navigationController?.pushViewController(vc, animated: true);
        self.presentViewController(vc, animated: true, completion: nil);
    }
}
