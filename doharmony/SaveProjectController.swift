//
//  SaveProjectController.swift
//  doharmony
//
//  Created by Daryl Super Duper Handsum on 08/03/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import AVFoundation

class SaveProjectController: UIViewController, mergeDelegate, cropDelegate {
    
    //title description thumbnail collab
    @IBOutlet weak var projectTitle: UITextField!
    @IBOutlet weak var projectDescription: UITextField!
    @IBOutlet weak var contributors: UITextField!
    
    var db = RecordingData()
    var Layout:UIView!
    var croppedAssets:[AVAsset] = []
    var duration:CMTime = kCMTimeZero
    var cropProgress:[Bool] = []
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func save(sender: AnyObject) {
        cropProgress = []
        for frame in Layout.subviews{
            let tag = frame.tag
            let record = db.fetch("Recordings", predicate: NSPredicate(format: "tag == %ld", NSInteger(tag)))
            if record.count>0 {
                let filename = record[0].valueForKey("record") as! String
                let filePath = env.documentFolder.stringByAppendingPathComponent("\(filename)")
                let fileURL = NSURL(fileURLWithPath: filePath)
                let Cropper = Crop()
                Cropper.delegate = self
                Cropper.crop(fileURL, frame: frame, filename: filename)
                cropProgress.append(false)
            }
        }
    }
    
    @IBAction func closeWindow(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didFinishCropping(frameTag: Int, cropOutputFileURL: NSURL) {
        cropProgress[frameTag] = true
        croppedAssets.append(AVAsset(URL: cropOutputFileURL))
        var alldone:Bool = true
        for var index = 0; index < cropProgress.count; index++ {
            if cropProgress[index] == false {
                alldone = false
            }
        }
        
        
        if alldone == true{
            print(Layout.subviews.count, croppedAssets.count, cropProgress.count)
            for asset in self.croppedAssets{
                if CMTimeCompare(asset.duration, self.duration) == 1{
                    self.duration = asset.duration
                }
            }
            Merge().exportSingleVideo(self.Layout, assets: self.croppedAssets, duration: self.duration)
        }
    }
    func mergeSuccess(outputFileURL: NSURL) {
        let title = NSString(string: projectTitle.text!)
        let trackPath = NSString(string: outputFileURL.absoluteString)
        let insert = ["title":title,"trackPath":trackPath]
        RecordingData().insert("Tracks", values: insert)
    }
}
