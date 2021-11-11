//
//  EndPoints.swift
//  SeatGeekApp
//
//  Created by amay on 09/11/21.
//

import Foundation

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public enum BaseUrl
{
    static let DevEnvironment = "https://api.seatgeek.com"
    static let UATEnvironment = "https://api.seatgeek.com"
    static let ProdEnvironment = "https://api.seatgeek.com"
}

public enum EndPointApi: String
{
    case getEventList = "/2/events?"
}
