//
//  EventListRouter.swift
//  SeatGeekApp
//
//  Created by amay on 09/11/21.

import UIKit

@objc protocol EventListRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol EventListDataPassing
{
  //var dataStore: EventListDataStore? { get }
}

class EventListRouter: NSObject, EventListRoutingLogic, EventListDataPassing
{
  weak var viewController: EventListViewController?
  //var dataStore: EventListDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: EventListViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: EventListDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
