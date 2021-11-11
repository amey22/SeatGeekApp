//
//  EventDetailsViewController.swift
//  SeatGeekApp
//
//  Created by amay on 10/11/21.

import UIKit

protocol EventDetailsDisplayLogic: AnyObject
{
  func displayFavouriteResult(viewModel: FavouriteModel.Response)
}

protocol FavouriteDelegate:AnyObject
{
    func markEventFavouriteStatus(event:EventModel.Events)
}


class EventDetailsViewController: UIViewController, EventDetailsDisplayLogic
{
    var interactor: EventDetailsBusinessLogic?
    var detailObj : EventModel.Events!
    weak var delegate : FavouriteDelegate?
    
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblVenue: UILabel!
    @IBOutlet var btnFavourite: UIButton!




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
    
  func loadData()
  {
    
    if let interactorObj = self.interactor
    {
        if interactorObj.isFavouriteEvent(request: FavouriteModel.Request(id: self.detailObj.id))
        {
            self.detailObj.isFavourite = true
            self.btnFavourite.tintColor = .red
        }
        else
        {
            self.detailObj.isFavourite = false
            self.btnFavourite.tintColor = .gray
        }
    }

    
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
  
  func displayFavouriteResult(viewModel: FavouriteModel.Response)
  {
    //nameTextField.text = viewModel.name
  }
    
    // MARK: Actions
      
      @IBAction func actionBack(_ sender: Any)
      {
          self.navigationController?.popViewController(animated: true)
      }
      
      @IBAction func actionFavourite(_ sender: Any)
      {
        let request = FavouriteModel.Request(id: self.detailObj.id)
        
        if self.detailObj.isFavourite
        {
            self.detailObj.isFavourite = false
            self.btnFavourite.tintColor = .gray
            self.interactor?.removeAsFavourite(request: request)
            
        }
        else
        {
            self.detailObj.isFavourite = true
            self.btnFavourite.tintColor = .red
            self.interactor?.saveAsFavourite(request: request)
        }
        
        if delegate != nil
        {
            delegate?.markEventFavouriteStatus(event: self.detailObj)
        }
      }
      
}
