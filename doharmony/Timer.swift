
import UIKit
import AVFoundation

protocol timerControllerCountdownDelegate{
    func countdownExpires()
}

protocol timerControllerStopTimerDelegate{
    func stopTimerExpires()
}

protocol timerControllerDurationTimerDelegate{
    func timeUpdate(h:Int,m:Int,s:Int)
}


class timerController:NSObject{
    var timer:NSTimer!
    var action:Selector!
    var interval:Double = 1
    var counter:Double = 0
    var isRunning:Bool = false
    
    //countdown
    var countdownDelegate:timerControllerCountdownDelegate!
    var cdFrame:UIView!
    var cdLabel:UILabel!
    var cdReturn:Selector!
    
    //metronome
    var tik:NSURL!
    var tok:NSURL!
    var tikPlayer:AVPlayer!
    var tokPlayer:AVPlayer!
    var measure:Double!
    
    //stoptimer
    var stopTimerDelegate:timerControllerStopTimerDelegate!
    var stopAt:Double!
    
    //durationtimer
    var minute = 0
    var hour = 0
    var durationTimerDelegate:timerControllerDurationTimerDelegate!
    
    override init(){
        super.init()
    }
    
    func setupDurationTimer(delegate:timerControllerDurationTimerDelegate){
        action = "durationtimer"
        durationTimerDelegate = delegate
    }
    
    func setupStopTimer(stop:Double, delegate:timerControllerStopTimerDelegate){
        stopAt = stop
        action = "stoptimer"
        stopTimerDelegate = delegate
    }
    
    func setupMetronome(bpm:Double,timeSignature:Double){
        action = "metronome"
        interval = 60/bpm
        measure = timeSignature
        tik = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tsak", ofType: "wav")!)
        tok = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("tsik", ofType: "wav")!)
    }
    
    func setupCountdown(start:Double, frame:UIView, delegate:timerControllerCountdownDelegate ){
        countdownDelegate = delegate
        action = "countdown"
        cdFrame = frame
        counter = start
        
        cdLabel = UILabel(frame: cdFrame.bounds)
        cdLabel.text = "\(Int(counter))"
        cdLabel.textColor = UIColor.orangeColor()
        cdLabel.font = UIFont.systemFontOfSize(CGFloat(cdFrame.frame.height/2))
        cdLabel.textAlignment = .Center
        cdFrame.addSubview(cdLabel)
    }
    
    func start(){
        timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: action, userInfo: nil, repeats: true)
        isRunning = true
    }

    func stop(){
        timer.invalidate()
        isRunning = false
        counter = 0
        interval = 1
        minute = 0
        hour = 0
    }
    
    //metronome
    func metronome(){
        counter++
        if counter == measure{
            counter = 0
            tokPlayer = AVPlayer(URL: tok)
            tokPlayer.play()
        }else{
            tikPlayer = AVPlayer(URL: tik)
            tikPlayer.play()
        }
    }
    
    //countdown
    func countdown(){
        counter--
        cdLabel.text = "\(Int(counter))"
        if(counter==0){
            cdLabel.text = ""
            cdLabel.removeFromSuperview()
            stop()
            countdownDelegate.countdownExpires()
        }
    }

    //stoptimer
    func stoptimer(){
        counter+=interval
        if counter >= stopAt{
            stop()
            stopTimerDelegate.stopTimerExpires()
        }
    }
    
    //durationtimer
    func durationtimer(){
        counter++
        if counter == 10{
            counter = 0
            minute++
        }
        if minute == 10{
            minute = 0
            hour++
        }
        durationTimerDelegate.timeUpdate(hour, m: minute, s: Int(counter))
    }

}