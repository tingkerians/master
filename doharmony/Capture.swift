import AVFoundation
import UIKit

class captureController{
    
    var audioSession:AVAudioSession
    var captureSession:AVCaptureSession
    var output:AVCaptureMovieFileOutput
    var outputPath:NSURL
    var layer:AVCaptureVideoPreviewLayer
    var Camera:AVCaptureDeviceInput
    var delegate:AVCaptureFileOutputRecordingDelegate!
    
    init(){
        captureSession = AVCaptureSession()
        audioSession = AVAudioSession()
        
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
    
    
    func start(filename:String){
        let Documents = env.documentFolder as String
        let recordOutputPath = NSURL.fileURLWithPath(Documents.stringByAppendingFormat("/\(env.recordingFolder)/record-\(filename).mov"))
        output.startRecordingToOutputFileURL(recordOutputPath, recordingDelegate: delegate)
    }
    
    func stop(){
        output.stopRecording()
        captureSession.stopRunning()
    }
    
    
    
}