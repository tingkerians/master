//
//  users.swift
//  doharmony
//
//  Created by khemer d great on 24/02/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class User{
    var id: String!
    var firstname: String!
    var lastname: String!
    var fullName: String!
    var username: String!
    var email: String!
    var dateCreated: String!
    var dateUpdated: String!
}

class Users{
    static let sharedInstance: Users! = Users()
    
    var userId: String! = ""
    var data: [Comment]?
    
    func setUserId(userId: String) -> Self {
        self.userId = userId
        return self
    }
    
    func request(callback: ((comments: [Comment])->Void)?){
        
    }
    
    func insertRecord(data: User, callback: ((result: Bool)->Void)?){
      
    }
    
    func updateRecord(data: User, callback: ((result: Bool)->Void)?){
        
    }
    
    func deleteRecord(data: User, callback: ((result: Bool)->Void)?){
        
    }
    
    func parse(data:[JSON]) -> [User]{
        var users: [User]! = [User]()
        
        data.forEach { (userJSON) -> () in
            
            let user: User! = User()
            user.id = userJSON["_id"].stringValue
            //            track.imagePath = env.apiUrl+"coverart/\(commentJSON["_id"].stringValue)"
            
            user.dateCreated = userJSON["date_created"].stringValue
            user.dateUpdated = userJSON["date_updated"].stringValue
            users.append(user)
            
        }
        
        return users!
    }
    
}