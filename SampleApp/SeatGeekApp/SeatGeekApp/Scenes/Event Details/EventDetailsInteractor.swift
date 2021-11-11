//
//  EventDetailsInteractor.swift
//  SeatGeekApp
//
//  Created by amay on 10/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol EventDetailsBusinessLogic
{
    func saveAsFavourite(request: FavouriteModel.Request)
    func removeAsFavourite(request: FavouriteModel.Request)
    func isFavouriteEvent(request: FavouriteModel.Request) -> Bool
}


class EventDetailsInteractor: EventDetailsBusinessLogic
{
  var presenter: EventDetailsPresentationLogic?
  var worker: EventDetailsWorker = EventDetailsWorker()
  //var name: String = ""
  
  // MARK: Do something
  
    func saveAsFavourite(request: FavouriteModel.Request)
    {
        worker.setFavouriteResults(id: request.id)
    }

    func removeAsFavourite(request: FavouriteModel.Request)
    {
        worker.removeFavourite(id:request.id )
    }
    
    func isFavouriteEvent(request: FavouriteModel.Request) -> Bool
    {
        return worker.isFavourite(id: request.id)
    }
    
}
