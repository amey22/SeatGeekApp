//
//  EventListModels.swift
//  SeatGeekApp
//
//  Created by amay on 09/11/21.

import UIKit

enum EventModel
{
  // MARK: Use cases
  
    struct Request:Codable
    {
        let searchString :String
    }
      
    struct ResponseStatus:Codable
    {
          let status : Int
          let message : String
          let eventList : [Events]?
        
          enum CodingKeys: String, CodingKey
          {
              case status = "status"
              case message = "message"
              case eventList = "events"
          }
          
          init(errorMsg:String)
          {
              status = 204
              message = errorMsg
              eventList = nil
          }
          
          init(from decoder: Decoder) throws {
              let values = try decoder.container(keyedBy: CodingKeys.self)
              status = try values.decodeIfPresent(Int.self, forKey: .status) ?? 204
              message = try values.decodeIfPresent(String.self, forKey: .message) ?? "NA"
              eventList = try values.decodeIfPresent([Events].self, forKey: .eventList)
          }
      }
     
     struct Events : Codable
     {
        let title : String
        let description : String
        let id : Int64
        var datetime : String
        let performers : [Performers]?
        let venue : Venue?


        enum CodingKeys: String, CodingKey
        {
            case title = "title"
            case description = "description"
            case id = "id"
            case datetime = "datetime_utc"
            case performers = "performers"
            case venue = "venue"
        }
      
      
        init(from decoder: Decoder) throws
        {
          let values = try decoder.container(keyedBy: CodingKeys.self)
            title = try values.decodeIfPresent(String.self, forKey: .title) ?? "NA"
            description = try values.decodeIfPresent(String.self, forKey: .description) ?? "NA"
            id = try values.decodeIfPresent(Int64.self, forKey: .id) ?? 0
            datetime = try values.decodeIfPresent(String.self, forKey: .datetime) ?? ""
            venue = try values.decodeIfPresent(Venue.self, forKey: .venue)
            performers = try values.decodeIfPresent([Performers].self, forKey: .performers)
            
            
            var date = datetime.replacingOccurrences(of: "T", with: " ").getDateFromString_yyyy_MM_dd_T_HH_mm_ss(timeZone: nil)

           // date = date?.globalTimeToLocal()
            
            datetime = date?.getStringFromDate_EEE_dd_MMM_yyyy_hh_mm_ss_a(timeZone: TimeZone.current) ?? ""
            
        }
     }

    struct Performers: Codable
    {
        let name : String
        let image : String

        enum CodingKeys: String, CodingKey
        {
            case name = "name"
            case image = "image"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
            image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
        }

    }
    
    struct Venue: Codable
    {
        let state : String
        let city : String
        let address : String
        let country : String
        let name : String

        enum CodingKeys: String, CodingKey
        {
            case state = "state"
            case city = "city"
            case address = "address"
            case country = "country"
            case name = "name"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            state = try values.decodeIfPresent(String.self, forKey: .state) ?? "NA"
            city = try values.decodeIfPresent(String.self, forKey: .city) ?? "NA"
            address = try values.decodeIfPresent(String.self, forKey: .address) ?? "NA"
            country = try values.decodeIfPresent(String.self, forKey: .country) ?? "NA"
            name = try values.decodeIfPresent(String.self, forKey: .name) ?? "NA"
        }

    }    
 
    struct ViewModel
    {
      var success: Bool
      var message: String
      var result:  [Events]?
    }

}

/**
 
 {"status":403,"message":"Invalid client credentials","errors":[{"message":"Invalid client credentials","code":40302}],"meta":{"status":403}}
 
 */
/*
 "": 5477904,
"": "2022-02-26T10:30:00",
 
 */
