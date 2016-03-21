import Photos

import Photos

class CameraRoll{
    
//    var videos = [AVAsset]()
//    var images = [UIImage]()
//    var imageManager:PHImageManager
//    var fetchResult:PHFetchResult
//    
//    init(){
//        imageManager = PHImageManager.defaultManager()
//        fetchResult = PHAsset.fetchAssetsWithMediaType(.Video, options: nil)
//        fetchResult.enumerateObjectsUsingBlock {
//            object, index, stop in
//            
//            let targetSize: CGSize = CGSizeMake(110, 100)
//            let contentMode: PHImageContentMode = .AspectFill
//            PHImageManager.defaultManager().requestImageForAsset(object as! PHAsset, targetSize: targetSize, contentMode: contentMode, options: nil) {
//                image, info in
//                self.images.append(image!)
//            }
//            
//            PHImageManager.defaultManager().requestAVAssetForVideo(object as! PHAsset, options: nil, resultHandler: {(asset:AVAsset?, audioMix: AVAudioMix?, info: [NSObject : AnyObject]?) -> Void in
//                self.videos.append(asset!)
//            })
//        }
//    }
    
    func save(path:NSURL){
        let library = PHPhotoLibrary.sharedPhotoLibrary()
        library.performChanges({
            PHAssetChangeRequest.creationRequestForAssetFromVideoAtFileURL(path)
            }, completionHandler: {success, error in
                NSLog("[CAMERA ROLL] Saving asset. %@", (success ? "Success." : error!))
        })
    }
    
    
}