//
//  EventListViewController.swift
//  SeatGeekApp
//
//  Created by amay on 09/11/21.

import UIKit

protocol EventListDisplayLogic: AnyObject
{
  func displayEventList(viewModel: EventModel.ViewModel)
}

class EventListViewController: UIViewController
{
    var interactor: EventListBusinessLogic?
    var arrEventList : [EventModel.Events] = []
    

    lazy var searchBar:UISearchBar = UISearchBar()
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var lblNoRecords: UILabel!


    
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
    let interactor = EventListInteractor()
    let presenter = EventListPresenter()
    viewController.interactor = interactor
    interactor.presenter = presenter
    presenter.viewController = viewController
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if segue.identifier == SegueKeys.ShowEventDetails
    {
        guard let destVc = segue.destination as? EventDetailsViewController else
        {
            return
        }
        destVc.detailObj = (sender as! EventModel.Events)
        destVc.delegate = self
    }
  }
  
  // MARK: View lifecycle
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    initialiseView()
    loadEventList(searchStr: "")
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
  
  // MARK: Create View 
  
  func initialiseView()
  {
    self.searchBar.sizeToFit()
    self.navigationItem.titleView = self.searchBar
 //   self.searchBar.showsCancelButton = true
    self.searchBar.delegate = self
    searchBar.searchTextField.leftView?.tintColor = .white
    searchBar.searchTextField.textColor = .white
    searchBar.tintColor = .white

    
    refreshControl = UIRefreshControl()
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    self.eventTableView.addSubview(refreshControl)
    
    self.eventTableView.register(UINib(nibName: "EventCardCell", bundle: nil), forCellReuseIdentifier: EventCardCellId)

  }
    
    
    @objc func refresh(_ sender: Any)
    {
       // if !self.refreshControl.isRefreshing
      //  {
            self.loadEventList(searchStr: "Texas+ranger")
      //  }
    }


    func loadEventList(searchStr: String)
    {
        self.interactor?.getEvents(request: EventModel.Request(searchString: searchStr))
    }
}

//MARK: - Display Protocols

extension EventListViewController : EventListDisplayLogic
{
    func displayEventList(viewModel: EventModel.ViewModel)
    {
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
        
        if viewModel.success
        {
            self.arrEventList.removeAll()

            if let eventList = viewModel.result
            {
                self.arrEventList.append(contentsOf: eventList)
            }
        }
        else
        {
            self.arrEventList.removeAll()
            print("Error : \(viewModel.message)")
        }
        
        DispatchQueue.main.async {
            self.eventTableView.reloadData()
        }

    }
}

extension EventListViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        self.lblNoRecords.isHidden = true
        if(arrEventList.count == 0 )
        {
            self.lblNoRecords.isHidden = false
        }

        return arrEventList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:EventCardCell = tableView.dequeueReusableCell(withIdentifier: EventCardCellId) as! EventCardCell
      //  cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell.configureEventCell(details:  self.arrEventList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.performSegue(withIdentifier: SegueKeys.ShowEventDetails, sender: self.arrEventList[indexPath.row])
    }
}


extension EventListViewController:UISearchBarDelegate
{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        self.loadEventList(searchStr: searchBar.text?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
        searchBar.searchTextField.resignFirstResponder()
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      //  print("textDidChange \(searchBar.text)")
        print(" textDidChange searchText \(searchText)")
        self.loadEventList(searchStr: searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
    }
    
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Stop doing the search stuff
        // and clear the text in the search bar
        searchBar.text = ""
        // Hide the cancel button
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.searchTextField.resignFirstResponder()
        self.loadEventList(searchStr: "")
    }
}


extension EventListViewController:FavouriteDelegate
{
    func markEventFavouriteStatus(event: EventModel.Events)
    {
        if let eventObjIndex = self.arrEventList.firstIndex(where: {$0.id == event.id})
        {
            self.arrEventList[eventObjIndex] = event
        }
        
       // self.arrEventList.filter({$0.id == event.id}).first?.isFavourite = event.isFavourite
        
        self.eventTableView.reloadData()
        
    }
    
    
}
