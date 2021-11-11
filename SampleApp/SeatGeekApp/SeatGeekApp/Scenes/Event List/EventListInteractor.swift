//
//  EventListInteractor.swift
//  SeatGeekApp
//
//  Created by amay on 09/11/21.

import UIKit

typealias eventListCompletionHandler = (_ response:EventModel.ResponseStatus) -> Void


protocol EventListBusinessLogic
{
    func getEvents(request: EventModel.Request)
}

class EventListInteractor: EventListBusinessLogic
{
  var presenter: EventListPresentationLogic?
  var worker: EventListWorker = EventListWorker()
  
  // MARK: Api Execution
  
  func getEvents(request: EventModel.Request)
  {
    worker.getEventList(request: request) { response in
        
        if response.eventList?.count != 0
        {
            let viewModelObj = EventModel.ViewModel.init(success:true, message: response.message, result: response.eventList)
            self.presenter?.presentEventList(viewModelObj: viewModelObj)
        }
        else
        {
            self.presenter?.presentEventList(viewModelObj: EventModel.ViewModel.init(success:false, message: response.message, result: nil))
        }
    }
    
  }
}
