import AVFoundation
import UIKit

class Merge{
    
    
    func exportSingleVideo(template:UIView, assets:[AVAsset], duration:CMTime){
        
        let composition = AVMutableComposition()
        var tracks = [AVMutableCompositionTrack]()
        
        for asset:AVAsset in assets{
            
            if asset.tracksWithMediaType(AVMediaTypeVideo).count > 0{
                let video = composition.addMutableTrackWithMediaType(AVMediaTypeVideo, preferredTrackID: kCMPersistentTrackID_Invalid)
                let audio = composition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
                do{
                    try video.insertTimeRange(CMTimeRangeMake(kCMTimeZero, duration), ofTrack: asset.tracksWithMediaType(AVMediaTypeVideo)[0], atTime: kCMTimeZero)
                    try audio.insertTimeRange(CMTimeRangeMake(kCMTimeZero, duration), ofTrack: asset.tracksWithMediaType(AVMediaTypeAudio)[0], atTime: kCMTimeZero)
                }catch{
                    NSLog("track insertion failed")
                }
                tracks.append(video)
            }else{
                let track = composition.addMutableTrackWithMediaType(AVMediaTypeAudio, preferredTrackID: kCMPersistentTrackID_Invalid)
                do{
                    try track.insertTimeRange(CMTimeRangeMake(kCMTimeZero, duration), ofTrack: asset.tracksWithMediaType(AVMediaTypeAudio)[0], atTime: kCMTimeZero)
                }catch{
                    NSLog("track insertion failed")
                }
            }
        }
        //main composition
        let mainComposition = AVMutableVideoComposition()
        mainComposition.frameDuration = CMTimeMake(1,30)
        mainComposition.renderSize = CGSizeMake(template.frame.width,template.frame.height)
        
        //instructions
        let mainInstruction = AVMutableVideoCompositionInstruction()
        mainInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, duration)
        
        var instructions = [AVMutableVideoCompositionLayerInstruction]()
        var index = 0
        for subview:UIView in template.subviews {
            let scaleX = (subview.frame.width / template.frame.width) / (tracks[index].naturalSize.width /  mainComposition.renderSize.width)
            let scaleY = (subview.frame.height / template.frame.height) / (tracks[index].naturalSize.height /  mainComposition.renderSize.height)
            let x = subview.frame.origin.x
            let y = subview.frame.origin.y
            
            let scale = CGAffineTransformMakeScale(scaleX, scaleY)
            let translate = CGAffineTransformMakeTranslation(x,y)
            let transform = CGAffineTransformConcat(scale, translate)
            
            let transformation = AVMutableVideoCompositionLayerInstruction(assetTrack: tracks[index])
            transformation.setTransform(transform, atTime: kCMTimeZero)
            instructions.append(transformation)
            index++
        }
        mainInstruction.layerInstructions = instructions
        mainComposition.instructions = [mainInstruction]
        
        //export
        let filename = randomStringWithLength(10)
        let Documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let mergedOutputPath = NSURL.fileURLWithPath(Documents.stringByAppendingString("/merged/merge-\(filename).mov"))
        
        let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)
        exportSession!.outputURL = mergedOutputPath
        exportSession!.videoComposition = mainComposition
        exportSession!.outputFileType = AVFileTypeQuickTimeMovie
        
        exportSession!.exportAsynchronouslyWithCompletionHandler({
            switch exportSession!.status{
            case .Failed:
                NSLog("export Failed")
            case .Cancelled:
                NSLog("export Canceled")
            default:
                NSLog("export Success")
            }
        })
        
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