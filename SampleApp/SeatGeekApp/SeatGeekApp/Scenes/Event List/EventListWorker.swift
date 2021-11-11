//
//  EventListWorker.swift
//  SeatGeekApp
//
//  Created by amay on 09/11/21.

import UIKit

class EventListWorker
{
    let networkLayer = NetworkLayerAlamofire() // Uncomment this in case do request using Alamofire for client request

    func getEventList(request:EventModel.Request , completionHandler :@escaping eventListCompletionHandler)
    {
         
        let errorHandler: (String) -> Void = { (strError) in
            let response = EventModel.ResponseStatus.init(errorMsg: strError)
             completionHandler(response)
         }
         
         let successHandler: (EventModel.ResponseStatus) -> Void = { (rewardsCategories) in
             completionHandler(rewardsCategories)
         }
         
         let headers = [
             "Content-Type": "application/json",
         ]
     
        let urlString = EndPointApi.getEventList.rawValue + "client_id=MjQzNTgwMTR8MTYzNjQ1MDcxMi43MjI4MDk&q=\(request.searchString)"

        self.networkLayer.get(urlString: urlString,headers: headers, successHandler: successHandler, errorHandler: errorHandler)
    }
}
