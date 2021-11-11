//
//  EventListPresenter.swift
//  SeatGeekApp
//
//  Created by amay on 09/11/21.

import UIKit

protocol EventListPresentationLogic
{
  func presentEventList(viewModelObj: EventModel.ViewModel)
}

class EventListPresenter: EventListPresentationLogic
{
  weak var viewController: EventListDisplayLogic?

    func presentEventList(viewModelObj: EventModel.ViewModel)
    {
        viewController?.displayEventList(viewModel:viewModelObj)
    }
}

