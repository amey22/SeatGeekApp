//
//  APIErrorModel.swift
//  SeatGeekApp
//
//  Created by amay on 09/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.


import Foundation

struct CustomError : Codable {
    let message : String?
    let status : Bool?
}

struct ResponseError : Codable
{
    let errorString : String?
    let errorDescription : String?
    var status: String?
    var message: String?
    
    enum CodingKeys: String, CodingKey {
        case errorString = "error"
        case errorDescription = "error_description"
        case status = "status"
        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorString = try values.decodeIfPresent(String.self, forKey: .errorString)
        errorDescription = try values.decodeIfPresent(String.self, forKey: .errorDescription)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }
}

struct AuthenticationError : Codable
{
    let error : String?
    let errorDescription : String?
    
    enum CodingKeys: String, CodingKey {
        case error = "error"
        case errorDescription = "error_description"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorDescription = try values.decodeIfPresent(String.self, forKey: .errorDescription)
    }
}


