//
//  AudioEffectsController.swift
//  doharmony
//
//  Created by Daryl Super Duper Handsum on 15/03/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import AVFoundation

class AudioEffectsController: UIViewController {

    @IBOutlet weak var filename: UILabel!
    let filemgr = NSFileManager.defaultManager()
    var player:AVAudioPlayer!
    var audioFile:AVAudioFile!
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tag = Layout.currentFrame
        let filter = NSPredicate(format: "tag == %ld", NSInteger(tag))
        let fetch = RecordingData().fetch("Recordings", predicate: filter)
        let file = fetch[0].valueForKey("record")!
        let audioFileName = file.stringByDeletingPathExtension + ".m4a"
        
        let recordFilePath = env.documentFolder.stringByAppendingPathComponent("/\(env.recordingFolder)/\(file)")
        let recordFileURL = NSURL(fileURLWithPath: recordFilePath)
        
        let audioOutputPath = env.documentFolder.stringByAppendingPathComponent("/\(env.recordingFolder)/Audio/\(audioFileName)")
        let audioOutputURL = NSURL.fileURLWithPath(audioOutputPath)
        if filemgr.fileExistsAtPath(audioOutputPath) {
            do{
                try filemgr.removeItemAtPath(audioOutputPath)
            }catch let er as NSError{
                print(er)
            }
        }
        
        //export
        let exporter = AVAssetExportSession(asset: AVAsset(URL: recordFileURL), presetName: AVAssetExportPresetAppleM4A)!
        exporter.outputFileType = AVFileTypeAppleM4A
        exporter.outputURL = audioOutputURL
        exporter.exportAsynchronouslyWithCompletionHandler({
            switch exporter.status{
            case .Failed:
                print("audio export failed:",exporter.error!)
                break
            case .Cancelled:
                NSLog("audio export cancelled")
                break
            default:
                print("audio export Success")
                dispatch_async(dispatch_get_main_queue()) {
                    self.filename.text = audioFileName
                    self.playBtn.userInteractionEnabled = true
                    self.stopBtn.userInteractionEnabled = true
                    self.playBtn.alpha = 1
                    self.stopBtn.alpha = 1
                }
                
                do{
                    self.audioFile = try AVAudioFile(forReading: audioOutputURL)
                    self.player = try AVAudioPlayer(contentsOfURL: audioOutputURL)
                }catch let er as NSError{
                    print("set audio file err:",er)
                }
                break
            }
        })
    }

    @IBAction func closeWindow(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func play(sender: AnyObject) {
        player.play()
    }
    @IBAction func stop(sender: AnyObject) {
        player.stop()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
