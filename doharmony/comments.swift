//
//  comments.swift
//  doharmony
//
//  Created by khemer d great on 24/02/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class Comment{
    var id: String!
    var author: String!
    var authorPic: String!
    var content: String!
    var dateCreated: String!
    var dateUpdated: String!
}

class Comments{
    static let sharedInstance: Comments! = Comments()
    
    var trackId: String! = ""
    var data: [Comment]?
    
    func setTrackId(trackId: String) -> Self {
        self.trackId = trackId
        return self
    }
    
    func request(callback: ((comments: [Comment])->Void)?){
        if(trackId.isEmpty == false){
            let url = env.apiUrl+"comments/"+self.trackId
            print(url)
            Alamofire.request(.GET, url)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        let result = JSON(response.result.value!);
                        if let data = result["comments"].arrayValue as [JSON]?{
                            self.data = self.parse(data)
                            callback?(comments: self.data!)
                        }
                    case .Failure(let error):
                        print("error4: ", error);
                    }
            }
        }
    }
    
    func insertRecord(data: Comment, callback: ((result: Bool)->Void)?){
        let url = env.apiUrl+"comments/"+trackId
        print(url)
        let token = Auth.sharedInstance.getToken()
        let parameters = [
            "content": data.content,
            "token": token["token"]
        ]
        print(parameters)
        Alamofire.request(.POST, url, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    callback?(result: true)
                case .Failure(let error):
                    print("error4: ", error);
                }
        }
    }
    
    func updateRecord(data: Comment, callback: ((result: Bool)->Void)?){
        
    }
    
    func deleteRecord(data: Comment, callback: ((result: Bool)->Void)?){
        
    }
    
    func parse(data:[JSON]) -> [Comment]{
        var comments: [Comment]! = [Comment]()
        
        data.forEach { (commentJSON) -> () in
            
            let comment: Comment! = Comment()
            comment.id = commentJSON["_id"].stringValue
//            track.imagePath = env.apiUrl+"coverart/\(commentJSON["_id"].stringValue)"
            
            comment.dateCreated = commentJSON["date_created"].stringValue
            comment.dateUpdated = commentJSON["date_updated"].stringValue
            comment.author = commentJSON["comment_author"].stringValue
            comment.content = commentJSON["content"].stringValue
            comments.append(comment)
            
        }
        
        return comments!
    }
    
}