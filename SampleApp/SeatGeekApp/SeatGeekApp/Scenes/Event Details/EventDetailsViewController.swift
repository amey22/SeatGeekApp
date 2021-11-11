//
//  EventDetailsViewController.swift
//  SeatGeekApp
//
//  Created by amay on 10/11/21.

import UIKit

protocol EventDetailsDisplayLogic: AnyObject
{
  func displayFavouriteResult(viewModel: EventModel.actionResponse)
}

class EventDetailsViewController: UIViewController, EventDetailsDisplayLogic
{
    var interactor: EventDetailsBusinessLogic?
    var detailObj : EventModel.Events!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblVenue: UILabel!



  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = EventDetailsInteractor()
    let presenter = EventDetailsPresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = viewController
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    loadData()
    initialiseView()
  }

  func initialiseView()
  {
    self.imgEvent.layer.cornerRadius = 12
    self.imgEvent.layer.masksToBounds = true
    self.imgEvent.contentMode = .scaleAspectFill
    
    self.navigationController!.navigationBar.isHidden = true
  }

    
    
  // MARK: Actions
    
    @IBAction func actionBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func actionFavourite(_ sender: Any)
    {
        
    }
    
  
  //@IBOutlet weak var nameTextField: UITextField!
  
  func loadData()
  {
    
    self.lblTitle.text = self.detailObj.title

    if let imgUrl = detailObj.performers?.first?.image {
        self.imgEvent.setCasheImage(imageURL: imgUrl, id: "E\(detailObj.id)")
    }

    if let venuePresent = detailObj.venue
    {
        self.lblVenue.text = "\(venuePresent.address), \(venuePresent.city) ,\(venuePresent.state)"
    }
    
    self.lblDate.text = detailObj.datetime

  }
  
  func displayFavouriteResult(viewModel: EventModel.actionResponse)
  {
    //nameTextField.text = viewModel.name
  }
}
