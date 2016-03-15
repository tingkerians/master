//
//  tracks.swift
//  doharmony
//
//  Created by khemer d great on 24/02/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class Track{
    var id: String!
    var image: UIImage!
    var imagePath: String! = ""
    var title: String!
    var author: String!
    var totalLikes: String!
    var totalViews: String!
    var dateCreated: String!
    var dateUpdated: String!
    var isLocal: Bool! = false
    var trackPath: String!
}

class Tracks{
    static let sharedInstance: Tracks! = Tracks()
    private var category: String! = ""
    private var date: String! = ""
    private var searchNSPredicate: NSPredicate?
    var search: String! = "" {
        didSet {
            if(search.isEmpty){
                searchNSPredicate = nil
            }else{
                searchNSPredicate = NSPredicate(format: "ANY title CONTAINS[c] %@", search)
            }
        }
    }
    var data: [Track]?
    
    init(){}
    
    static func createTrackFolder(){
        let fileManger = NSFileManager.defaultManager()
        let createpath = env.documentFolder.stringByAppendingPathComponent("\(env.tracksFolder)")
        do {
            try fileManger.createDirectoryAtPath(createpath, withIntermediateDirectories: false, attributes: nil)
            //print("folder created")
        } catch {
            //print("folder already created")
        }
    }
    
    func setCategory(category: String) -> Self {
        self.category = category
        return self
    }
    
    func setDate(date: String) -> Self {
        self.date = date
        return self
    }
    
    func setSearch(search: String) -> Self {
        self.search = search
        return self
    }
    
    func local() -> [Track]{
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Tracks")
        fetchRequest.predicate = self.searchNSPredicate
        
        var data : [NSManagedObject]?
        var tracks: [Track]?
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            data = results as? [NSManagedObject]
            tracks = self.parse(data!)
        } catch{
            print("error3")
        }
        
        return tracks!
    }
    
    func request(callback: ((tracks: [Track])->Void)?){
        let url = env.apiUrl+"tracks"
        
        let parameters = [
            "category" : self.category,
            "search" : self.search,
            "date" : self.date
        ];
        
        Alamofire.request(.GET, url, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let result = JSON(response.result.value!);
                    if let data = result["data"].arrayValue as [JSON]?{
                        print(data)
                        self.data = self.parse(data)
                        callback?(tracks: self.data!)
                    }
                case .Failure(let error):
                    print(error)
                    print("Tracks Network Error!");
                    self.data = [Track]()
                    callback?(tracks: self.data!)
                }
        }
    }
    
    func insertRecord(data: Track, callback: ((result: Bool)->Void)?){
        
    }
    
    func updateRecord(data: Track, callback: ((result: Bool)->Void)?){
        
    }
    
    func deleteRecord(data: Track, callback: ((result: Bool)->Void)?){
        
    }
    
    func parse(data:[JSON]) -> [Track]{
        var tracks: [Track]! = [Track]()
        
        data.forEach { (trackJSON) -> () in
            
            let track: Track! = Track()
            track.id = trackJSON["id"].stringValue
            track.title = trackJSON["title"].stringValue
            track.imagePath = env.apiUrl+"coverart/\(trackJSON["id"].stringValue)"
            
            
            track.totalViews = trackJSON["views"].stringValue
            track.totalLikes = trackJSON["likes"].stringValue
            track.dateCreated = trackJSON["date_created"].stringValue
            track.dateUpdated = trackJSON["date_updated"].stringValue
            track.author = trackJSON["author"].stringValue
            track.trackPath = ""
            tracks?.append(track)
            
        }
      
        return tracks!
    }
    
    func parse(data: [NSManagedObject]) ->[Track]{
        var tracks: [Track]! = [Track]()
        
        data.forEach { (trackCoreData) -> () in
            
            let track: Track! = Track()
            track.id = ""
            track.title = trackCoreData.valueForKey("title") as? String
            track.imagePath = trackCoreData.valueForKey("imagePath") as? String
            track.dateCreated = trackCoreData.valueForKey("dateCreated") as? String
            track.dateUpdated = trackCoreData.valueForKey("dateUpdated") as? String
            track.author = trackCoreData.valueForKey("author") as? String
            track.trackPath = trackCoreData.valueForKey("trackPath") as? String
            track.isLocal = true
            tracks?.append(track)
            
        }
        
        return tracks!
    }
    
}
