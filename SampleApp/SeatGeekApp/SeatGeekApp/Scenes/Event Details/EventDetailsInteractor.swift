//
//  EventDetailsInteractor.swift
//  SeatGeekApp
//
//  Created by amay on 10/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol EventDetailsBusinessLogic
{
    func saveAsFavourite(request: EventModel.Events)
}


class EventDetailsInteractor: EventDetailsBusinessLogic
{
  var presenter: EventDetailsPresentationLogic?
  var worker: EventDetailsWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func saveAsFavourite(request: EventModel.Events)
  {
    worker = EventDetailsWorker()
    worker?.saveAsFavourite()
  }
}
