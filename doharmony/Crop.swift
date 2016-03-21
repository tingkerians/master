import UIKit
import AVFoundation

protocol cropDelegate{
    func didFinishCropping(frameTag:Int,cropOutputFileURL:NSURL)
}

class Crop{
    
    var delegate:cropDelegate!
    
    func crop(fileURL:NSURL, frame:UIView, filename:String){
        NSLog("[CROP] cropping... -> \(filename)")
        let captureAsset = AVAsset(URL: fileURL)
        let videoTrack = captureAsset.tracksWithMediaType(AVMediaTypeVideo)[0]
        let duration = captureAsset.duration
        
        //composition
        let composition = AVMutableComposition()
        let videoComposition = AVMutableVideoComposition()
        let instruction = AVMutableVideoCompositionInstruction()
        
        let video = composition.addMutableTrackWithMediaType(AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
        let audio = composition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID:kCMPersistentTrackID_Invalid)
        do{
            try video.insertTimeRange(CMTimeRangeMake(kCMTimeZero, duration), ofTrack: videoTrack, atTime: kCMTimeZero)
            try audio.insertTimeRange(CMTimeRangeMake(kCMTimeZero, duration), ofTrack: captureAsset.tracksWithMediaType(AVMediaTypeAudio)[0], atTime: kCMTimeZero)
        }catch{
            NSLog("[CROP] video track insertTimeRange Er")
        }
        
        //crop
        let videoHeight = video.naturalSize.height
        let videoWidth = video.naturalSize.width
        
        let frameWidth = frame.frame.width
        let frameHeight = frame.frame.height
        var cropWidth = CGFloat(Int(videoHeight))
        var cropHeight = CGFloat(Int((frameHeight / frameWidth) * videoHeight))
        
        var posX = cropWidth
        if(videoWidth<cropHeight){
            cropHeight = CGFloat(Int(videoWidth))
            cropWidth = CGFloat(Int((frameWidth / frameHeight) * videoWidth))
            posX = cropWidth+((videoHeight - cropWidth)/2)
        }
        
        while cropWidth%4 != 0{cropWidth--}
        while cropHeight%4 != 0{cropHeight--}
        
        let posY = 0-frame.frame.origin.x
        
        videoComposition.frameDuration = CMTimeMake(1,30)
        videoComposition.renderSize = CGSizeMake(cropWidth,cropHeight)
        instruction.timeRange = CMTimeRangeMake(kCMTimeZero, duration)
        
        //rotate
        let transformer = AVMutableVideoCompositionLayerInstruction(assetTrack: video)
        let t1 = CGAffineTransformMakeTranslation(posX, posY)
        
        let transform = CGAffineTransformRotate(t1, CGFloat(M_PI_2))
        
        transformer.setTransform(transform, atTime: kCMTimeZero)
        
        instruction.layerInstructions = [transformer]
        videoComposition.instructions = [instruction]
        
        //export
        let Documents = env.documentFolder
        let cropOutputFileURL = NSURL.fileURLWithPath(Documents.stringByAppendingString("/Crop/\(fileURL.lastPathComponent!)"))
        if NSFileManager.defaultManager().fileExistsAtPath(cropOutputFileURL.path!){
            do{
                try NSFileManager.defaultManager().removeItemAtPath(cropOutputFileURL.path!)
            }catch let er as NSError{
                print("Error removing existing item:",er)
            }
        }
        
        let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)!
        exporter.videoComposition = videoComposition
        exporter.outputFileType = AVFileTypeQuickTimeMovie
        exporter.outputURL = cropOutputFileURL
        exporter.exportAsynchronouslyWithCompletionHandler({
            switch exporter.status{
            case .Failed:
                print("[CROP] crop failed",exporter.error!)
            case .Cancelled:
                NSLog("[CROP] crop canceled")
            default:
                NSLog("[CROP] crop success -> \(filename)")
                self.delegate.didFinishCropping(frame.tag,cropOutputFileURL: exporter.outputURL!)
            }
        })
    }
    
    func getOrientation(track:AVAssetTrack)->UIInterfaceOrientation{
        let transformation = track.preferredTransform
        let size:CGSize = track.naturalSize
        let orientation:UIInterfaceOrientation
        if (size.width == transformation.tx && size.height == transformation.ty){
            orientation = .LandscapeRight;
        }
        else if (transformation.tx == 0 && transformation.ty == 0){
            orientation = .LandscapeLeft
        }
        else if (transformation.tx == 0 && transformation.ty == size.width){
            orientation = .PortraitUpsideDown
        }
        else{
            orientation = .Portrait
        }
        return orientation
    }
    
}

