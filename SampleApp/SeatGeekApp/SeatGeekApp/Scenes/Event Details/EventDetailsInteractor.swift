//
//  EventDetailsInteractor.swift
//  SeatGeekApp
//
//  Created by amay on 10/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol EventDetailsBusinessLogic
{
  func doSomething(request: EventDetails.Something.Request)
}

protocol EventDetailsDataStore
{
  //var name: String { get set }
}

class EventDetailsInteractor: EventDetailsBusinessLogic, EventDetailsDataStore
{
  var presenter: EventDetailsPresentationLogic?
  var worker: EventDetailsWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: EventDetails.Something.Request)
  {
    worker = EventDetailsWorker()
    worker?.doSomeWork()
    
    let response = EventDetails.Something.ViewModel()
    presenter?.presentSomething(response: response)
  }
}
