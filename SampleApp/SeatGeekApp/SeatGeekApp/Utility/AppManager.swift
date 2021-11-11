//
//  AppManager.swift
//  SeatGeekApp
//
//  Created by amay on 11/11/21.
//

import UIKit
import Kingfisher

class AppManager: NSObject
{
    static let shared = AppManager()
    let appUserDefault = UserDefaults.standard
    let appDelegate = AppDelegate.sharedInstance
    
    
    private override init() {
        super.init()
    }
    
    func initialiseManager()
    {
    
    }
    
    func clearAppImageCache()
    {
        ImageCache.default.clearMemoryCache()
        ImageCache.default.clearDiskCache()
    }
    
    func getClientIdForGeekResources()->String
    {
        var resourceFileDictionary: NSDictionary?
        //Load content of Info.plist into resourceFileDictionary dictionary
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            resourceFileDictionary = NSDictionary(contentsOfFile: path)
        }
        
        if let resourceFileDictionaryContent = resourceFileDictionary
        {
            
           if let dict = resourceFileDictionaryContent.object(forKey: "ApiKeys") as? NSDictionary
           {
             return (dict.value(forKey: "ClientKey") as? String) ?? ""
           }
           else
           {
             return ""
           }
        }
        
        return ""

    }
   
}
/*
 
}

 */
