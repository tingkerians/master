//
//  config.swift
//  doharmony
//
//  Created by khemer d great on 23/02/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//
import UIKit
struct env{
    static let apiUrl = "192.168.0.1/api/"
    static let doharmonyUrl = "www.doharmony.com"
    
    static let documentFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString
    static let tracksFolder = "Doharmony"
    
    static let languageCode = ((NSLocale.preferredLanguages()[0]).characters.split{$0 == "-"}.map(String.init))[0]
    
    static let CAPSPageMenuOptions : [CAPSPageMenuOption] = [
        .ScrollMenuBackgroundColor(UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
        .ViewBackgroundColor(UIColor(red: 20.0/255.0, green: 20.0/255.0, blue: 20.0/255.0, alpha: 1.0)),
        .SelectionIndicatorColor(UIColor.orangeColor()),
        .BottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
        .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
        .MenuHeight(40.0),
        .MenuItemWidth(65.0),
        .CenterMenuItems(true)
    ]
}

struct locale{
    static let Change = "Change".localized()
    static let HelloWorld = "Hello World".localized()
    static let Reset = "Reset".localized()
    static let Recent = "Recent".localized()
    static let Popular = "Popular".localized()
    static let Best = "Best".localized()
    static let Local = "Local".localized()
    static let LastWeek = "Last Week".localized()
    static let LastMonth = "Last Month".localized()
    static let AllTime = "All Time".localized()
    static let Post = "Post".localized()
    static let MyFriends = "My Friends".localized()
    static let AllMembers = "All Members".localized()
    static let Templates = "Templates".localized()
    static let Record = "Record".localized()
    static let Tracks = "Tracks".localized()
    static let MyProfile = "My Profile".localized()
    static let MyTracks = "My Tracks".localized()
    static let MyProjects = "My Project".localized()
    static let Videos = "Videos".localized()
    static let Friends = "Friends".localized()
    static let Followers = "Followers".localized()
    static let Following = "Following".localized()
    static let Notification = "Notification".localized()
    static let Welcome = "Welcome".localized()
    static let Login = "Login".localized()
    static let Logout = "Logout".localized()
    static let All = "All".localized()
}