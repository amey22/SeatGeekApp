//
//  EventCardCell.swift
//  SeatGeekApp
//
//  Created by amay on 10/11/21.
//

import UIKit

let EventCardCellId = "eventCardCellId"

class EventCardCell: UITableViewCell {

    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblVenue: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet  var btnFavourite: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.imgEvent.layer.cornerRadius = 12
        self.imgEvent.layer.masksToBounds = true
        self.imgEvent.contentMode = .scaleAspectFill
    }
    
    
    
    func configureEventCell(details: EventModel.Events)
    {
        self.lblTitle.text = details.title
        self.lblVenue.isHidden = false
        
        if let venuePresent = details.venue
        {
            self.lblVenue.text = "\(venuePresent.address), \(venuePresent.city) ,\(venuePresent.state)"
        }
        else
        {
            self.lblVenue.isHidden = true
        }
        
        if let imagePresent = details.performers?.first?.image {
            self.imgEvent.setCasheImage(imageURL: imagePresent, id: "E\(details.id)")
        }
        
        self.lblDate.text = details.datetime
        
        self.btnFavourite.isHidden = !details.isFavourite
    }

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
