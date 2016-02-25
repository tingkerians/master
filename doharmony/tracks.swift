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
    
//    private var category: String?
//    private var date: String?
//    private var search: String?
//    private var isLocal: Bool = false
    
    init(){
    }
    
    func setCategory(category: String) -> Self {
        return self
    }
    
    func setDate(date: String) -> Self {
        return self
    }
    
    func setSearch(search: String) -> Self {
        return self
    }
    
    func isLocal(local: Bool) -> Self {
        return self
    }
    
    func request(callback: ((tracks: [JSON])->Void)?){
        let url = "http://192.168.0.137:8080/api/tracks"
        
        let parameters = [
            "category" : "popular"
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