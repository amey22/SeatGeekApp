//
//  EventDetailsPresenter.swift
//  SeatGeekApp
//
//  Created by amay on 10/11/21.

import UIKit

protocol EventDetailsPresentationLogic
{
    func presentSomething(response: EventDetails.Something.ViewModel)
}

class EventDetailsPresenter: EventDetailsPresentationLogic
{
  weak var viewController: EventDetailsDisplayLogic?
  
  // MARK: Do something
  
  func presentSomething(response: EventDetails.Something.ViewModel)
  {
    viewController?.displayFavouriteResult(viewModel: response)
  }
}
