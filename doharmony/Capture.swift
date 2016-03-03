import AVFoundation
import UIKit

class captureController{
    
    var captureSession:AVCaptureSession
    var output:AVCaptureMovieFileOutput
    var outputPath:NSURL
    var layer:AVCaptureVideoPreviewLayer
    var Camera:AVCaptureDeviceInput
    
    init(){
        captureSession = AVCaptureSession()
        output = AVCaptureMovieFileOutput()
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        var defaultAudioInput:AVCaptureDeviceInput!
        var defaultVideoInput:AVCaptureDeviceInput!
        do{
            try defaultAudioInput = AVCaptureDeviceInput(device: AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeAudio))
            try defaultVideoInput = AVCaptureDeviceInput(device: AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo))
        }catch{
            NSLog("Input Device Er")
        }
        Camera = defaultVideoInput
        captureSession.addInput(defaultVideoInput)
        captureSession.addInput(defaultAudioInput)
        captureSession.addOutput(output)
        
        
        outputPath = NSURL.fileURLWithPath(NSTemporaryDirectory() as String)
        layer = AVCaptureVideoPreviewLayer(session: captureSession)
    }
    
    func changeCamera(){
        captureSession.removeInput(Camera)
        let videoDevices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        var captureDevice:AVCaptureDevice!
        for device in videoDevices{
            let device = device as! AVCaptureDevice
            if Camera.device.position == .Back && device.position == .Front{
                captureDevice = device
            }else if Camera.device.position == .Front && device.position == .Back{
                captureDevice = device
            }
        }
        do{
            try Camera = AVCaptureDeviceInput(device: captureDevice)
        }catch{
            NSLog("Camera Er")
        }
        captureSession.addInput(Camera)
        
    }
    
    func setCaptureLayer(captureFrame:UIView){
        layer = AVCaptureVideoPreviewLayer(session: captureSession)
        captureFrame.layer.addSublayer(layer)
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        layer.frame = captureFrame.layer.bounds
    }
    
    
    func start(delegate:AVCaptureFileOutputRecordingDelegate,filename:String){
        let Documents = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let recordOutputPath = NSURL.fileURLWithPath(Documents.stringByAppendingFormat("/record-\(filename).mov"))
        output.startRecordingToOutputFileURL(recordOutputPath, recordingDelegate: delegate)
    }
    
    func stop(){
        output.stopRecording()
        captureSession.stopRunning()
    }
    
}