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


class _tracks{
    
    private var category: String!
    private var date: String!
    private var search: String!
    private var isLocal: Bool!
    
    init(){
        self.isLocal = false
        self.category = ""
        self.date = ""
        self.search = ""
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
    
    func isLocal(local: Bool) -> Self {
        self.isLocal = local
        return self
    }
    
    func request(callback: ((tracks: [JSON])->Void)?){
        let url = "http://192.168.0.137:8080/api/tracks"
        
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
                        callback?(tracks: data)
                    }
                case .Failure(let error):
                    print("error4: ", error);
                }
        }
        
    }
    
}