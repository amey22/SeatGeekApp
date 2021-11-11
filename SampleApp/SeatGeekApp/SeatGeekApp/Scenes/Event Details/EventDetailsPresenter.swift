//
//  EventDetailsPresenter.swift
//  SeatGeekApp
//
//  Created by amay on 10/11/21.

import UIKit

protocol EventDetailsPresentationLogic
{
    func presentResult(response: EventModel.actionResponse)
}

class EventDetailsPresenter: EventDetailsPresentationLogic
{
  weak var viewController: EventDetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentResult(response: EventModel.actionResponse)
  {
    viewController?.displayFavouriteResult(viewModel: response)
  }
}
