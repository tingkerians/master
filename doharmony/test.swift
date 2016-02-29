//
//  test.swift
//  doharmony
//
//  Created by khemer d great on 24/02/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import CoreData

class test{
    var doharmonyFolder = "doHarmonyTraxs"
    var extString = [String]()
    
    init(){
        let fileManger = NSFileManager.defaultManager()
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
        let createpath = documentDirectoryPath.stringByAppendingPathComponent("\(doharmonyFolder)")
        do {
            try fileManger.createDirectoryAtPath(createpath, withIntermediateDirectories: false, attributes: nil)
            print("folder Created")
        } catch {
            print("error")
        }
        extString = ["mp4","MP4","mov","MOV","m4v","M4V"]
        let file = fileManger.enumeratorAtPath(NSBundle.mainBundle().resourcePath! as String)
        while let files = file?.nextObject() {
            for(var index = 0; index < extString.count; index++) {
                if files.pathExtension == extString[index] {
                    let nameOnly = (NSURL(fileURLWithPath: files as! String).URLByDeletingPathExtension?.lastPathComponent)
                    let destinationPath = documentDirectoryPath.stringByAppendingPathComponent("\(doharmonyFolder)/\(files)")
                    let sourcePath = NSBundle.mainBundle().pathForResource("\(nameOnly!)", ofType: "\(files.pathExtension!)")
                    do{
                        try fileManger.copyItemAtPath(sourcePath!, toPath: destinationPath)
                        let filePath = "\(doharmonyFolder)/\(nameOnly!).\(files.pathExtension!)"
                        //print("\(filePath)\n\(doharmonyFolder)\n\(nameOnly!)\n\(files.pathExtension!)")
                        saveTrackToCoreData(String: filePath, nameOnly: nameOnly!, username: "default",trackimage: "default")
                        
                    } catch {
                        print("error1")
                    }
                }
            }
        }

    }
    
    
    func saveTrackToCoreData(String destinationPath:String,nameOnly:String,username:String,trackimage:String){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let manageContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("Tracks", inManagedObjectContext: manageContext)
        let music = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: manageContext)
        
        music.setValue(destinationPath, forKey: "trackpath")
        music.setValue(nameOnly, forKey: "trackname")
        music.setValue(username, forKey: "username")
        music.setValue(trackimage, forKey: "trackimage")
        
        
        do{
            try manageContext.save()
            print("saved: ",nameOnly)
            
        } catch let err as NSError {
            print("Could no save \(err), \(err.userInfo)")
        }
        
    }
}