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