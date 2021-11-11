//
//  EventDetailsWorker.swift
//  SeatGeekApp
//
//  Created by amay on 10/11/21.

import UIKit

class EventDetailsWorker
{

    
    /*Idea to user userdefault to save favourite record was just to avoid using unnecessary use of core data as it is heavy operation. If there are more Information needs to store or If we need to show Favourite Result Then use CoreData or Other relational Db
     */

    func getFavouriteResults()->[Int64]
    {
        return AppManager.shared.appUserDefault.object(forKey: AppKeys.FavouriteResults) as? [Int64] ?? []
    }
    
    func setFavouriteResults(id:Int64)
    {
        var favouriteArr = self.getFavouriteResults()
       
        if !favouriteArr.contains(where: {$0 == id})
        {
            favouriteArr.append(id)
            AppManager.shared.appUserDefault.set(favouriteArr, forKey:  AppKeys.FavouriteResults)
            AppManager.shared.appUserDefault.synchronize()
        }
    }
    
    func removeFavourite(id:Int64)
    {
        var favouriteArr = self.getFavouriteResults()
       
        if let index = favouriteArr.firstIndex(of: id)
        {
            favouriteArr.remove(at: index)
            AppManager.shared.appUserDefault.set(favouriteArr, forKey:  AppKeys.FavouriteResults)
            AppManager.shared.appUserDefault.synchronize()
        }
    }
    
    func isFavourite(id:Int64)->Bool
    {
        var favouriteArr = self.getFavouriteResults()
       
        if favouriteArr.contains(where: {$0 == id})
        {
           return true
        }
        
        return false
    }
}
