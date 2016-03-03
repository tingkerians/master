import UIKit
import AVFoundation

class Crop{
    
    func crop(recordPath:NSURL, frame:UIView, captureLayer:AVCaptureVideoPreviewLayer, filename:String)->NSURL{
        
        let captureAsset = AVAsset(URL: recordPath)
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
            NSLog("video track insertTimeRange Er")
        }
        
        //crop
        let videoHeight = video.naturalSize.height
        let frameWidth = frame.frame.width
        let frameHeight = frame.frame.height
        let cropWidth = videoHeight
        let cropHeight = (frameHeight / frameWidth) * cropWidth
        
        let B: CGPoint = CGPointMake(frame.bounds.size.width, frame.bounds.origin.y)
        let b: CGPoint = captureLayer.captureDevicePointOfInterestForPoint(B)
        let posX: CGFloat = floor(b.x * videoHeight)
        
        videoComposition.frameDuration = CMTimeMake(1,30)
        videoComposition.renderSize = CGSizeMake(cropWidth,cropHeight)
        instruction.timeRange = CMTimeRangeMake(kCMTimeZero, duration)
        
        //rotate
        let transformer = AVMutableVideoCompositionLayerInstruction(assetTrack: video)
        let t1 = CGAffineTransformMakeTranslation(cropWidth, 0-posX)
        let transform = CGAffineTransformRotate(t1, CGFloat(M_PI_2))
        transformer.setTransform(transform, atTime: kCMTimeZero)
        
        instruction.layerInstructions = [transformer]
        videoComposition.instructions = [instruction]
        
        
        //export
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let Documents = path[0]
        let croppedOutputPath = NSURL.fileURLWithPath(Documents.stringByAppendingString("/crop-\(filename).mov"))
        
        let exporter = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)!
        exporter.videoComposition = videoComposition
        exporter.outputFileType = AVFileTypeQuickTimeMovie
        exporter.outputURL = croppedOutputPath
        exporter.exportAsynchronouslyWithCompletionHandler({
            switch exporter.status{
            case .Failed:
                NSLog("[CROP] export Failed")
            case .Cancelled:
                NSLog("[CROP] export Canceled")
            default:
                NSLog("[CROP] export Success")
            }
        })
        
        return exporter.outputURL!
    }
    
    
}

