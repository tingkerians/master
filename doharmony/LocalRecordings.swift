
import CoreData
import AVFoundation

class localRecordings{
    
    var filenames:[String] = []

    init(){
        filenames = getDocumentFolderContents()
    }
    
    func getRecordingFolderContents()->[String]{
        var recordings:[String] = []
        do{
            let recordingContents = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(env.documentFolder.stringByAppendingPathComponent("Recording"))
            recordings = recordingContents.filter{ $0.pathExtension == "mov" }.map{ $0.lastPathComponent }
        }catch let er as NSError{
            print(er)
        }
        return recordings
    }
    
    func getDocumentFolderContents()->[String]{
        var localFiles:[String] = []
        let filemgr = NSFileManager.defaultManager()
        let enumerator:NSDirectoryEnumerator = filemgr.enumeratorAtPath(env.documentFolder as String)!
        while let element = enumerator.nextObject() as? String {
            let folder = element.characters.split("/").map(String.init)
            if folder[0] != "Crop" && (element.hasSuffix("mov") || element.hasSuffix("mp4")) {
                localFiles.append(element)
            }
        }
        return localFiles
    }
}

extension String {
    var ns: NSString {
        return self as NSString
    }
    var pathExtension: String {
        return ns.pathExtension ?? ""
    }
    var lastPathComponent: String {
        return ns.lastPathComponent ?? ""
    }
}