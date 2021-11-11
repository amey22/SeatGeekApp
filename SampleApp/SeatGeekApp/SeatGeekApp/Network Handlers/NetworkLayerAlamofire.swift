//  SeatGeekApp
//
//  Created by amay on 09/11/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import Foundation
import Alamofire

typealias NetworkCompletionHandlerAlamofire = (AFDataResponse<Data>) -> Void
public typealias ErrorHandlerAlamofire = (String) -> Void

open class NetworkLayerAlamofire
{
    static let genericError = "Something went wrong. Please try again later"
    static let invalidLogin = "Session is expired. Please Re-Login."
    static let parsingError = "Something went wrong in decoding response. Please try again later"

    public init()
    {
        
    }
    //MARK:- URL base end point
        
    func createBaseUrl(endPoint: String ,baseUrl:String?) -> String
    {
        if let baseurl = baseUrl
        {
            var finalEndpoint = ""
                    finalEndpoint = String(format:"%@%@",baseurl,endPoint)
            return finalEndpoint
        }
        
        let url = BaseUrl.DevEnvironment
        var  BaseUrl = url
        #if DEVELOPMENT
        BaseUrl = url
        #elseif STAGING
        BaseUrl = url
        #elseif PRODUCTION
        BaseUrl = url
        #endif
        var finalEndpoint = ""
        finalEndpoint = String(format:"%@%@",BaseUrl,endPoint)
        return finalEndpoint
    }
        
    func getHeaders()->HTTPHeaders
    {
           let headers: HTTPHeaders = ["Authorization":"OAuth oauth_consumer_key=pyxchhddffrlz2mivlpsjb89p2brgh7s,oauth_token=mohcgak6qqie9ub5onbqjvzfbj37ukjv,oauth_signature_method=HMAC-SHA1,oauth_timestamp=1553066664,oauth_nonce=BCFVAk3fpir,oauth_version=1.0,oauth_signature=i5BL9XlUrSV%2Bj2ZtgGQlpMBkvC8%3D"]
           return headers
    }
    
    func checkForNetworkConnection(errorHandler: @escaping ErrorHandlerAlamofire)
    {
        if !NetworkRechability.isConnectedToNetwork()
        {
            errorHandler("Please check your internet connection.")
            return
        }
    }
    
    //MARK:- Delete
    
    open func delete<T: Encodable,F:Decodable>(endPoint: String,
                                    body: T?,
                                    headers: [String: String] = [:],
                                    successHandler: @escaping (F) -> Void,
                                    errorHandler: @escaping ErrorHandlerAlamofire)
    {
        
        checkForNetworkConnection(errorHandler: errorHandler)
        
        let completionHandler: NetworkCompletionHandlerAlamofire = { (DataResponse) in
            self.genericResponseParsing(DataResponse: DataResponse, successHandler: successHandler, errorHandler: errorHandler)
        }
        
        guard let url = URL(string: createBaseUrl(endPoint: endPoint, baseUrl: nil)) else {
            return errorHandler("Unable to create URL from given string")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
       // request.allHTTPHeaderFields = getHeaders()
        if(!headers.isEmpty){
            for (key,value) in headers{
                request.allHTTPHeaderFields?[key] = value
            }
        }
        request.timeoutInterval = 90
                
        AF.request(request).responseData(completionHandler: completionHandler)
    }
    
     //MARK:- GET API
    
    open func get<T: Encodable,F:Decodable>(urlString: String,
                                            params: T?,
                                            headers: [String: String] = [:],
                                            successHandler: @escaping (F) -> Void,
                                            errorHandler: @escaping ErrorHandlerAlamofire)
    {
        checkForNetworkConnection(errorHandler: errorHandler)
        
        let completionHandler: NetworkCompletionHandlerAlamofire = { (DataResponse) in
            self.genericResponseParsing(DataResponse: DataResponse, successHandler: successHandler, errorHandler: errorHandler)
        }
        
        guard let url = URL(string: createBaseUrl(endPoint: urlString, baseUrl: nil)) else {
            return errorHandler("Unable to create URL from given string")
        }
        
        var request = URLRequest(url: url)
        if(!headers.isEmpty){
            for (key,value) in headers{
                request.allHTTPHeaderFields?[key] = value
            }
        }
        
        print("\n date : \(Date()) urlRequest \(String(describing: request.url)) \n\n")
        request.timeoutInterval = 90
        AF.request(request).responseData(completionHandler: completionHandler)
    }
    
    open func get<F:Decodable>(urlString: String,
                                            headers: [String: String] = [:],
                                            successHandler: @escaping (F) -> Void,
                                            errorHandler: @escaping ErrorHandlerAlamofire)
    {
        checkForNetworkConnection(errorHandler: errorHandler)
        
        let completionHandler: NetworkCompletionHandlerAlamofire = { (DataResponse) in
            self.genericResponseParsing(DataResponse: DataResponse, successHandler: successHandler, errorHandler: errorHandler)
        }
        
        guard let url = URL(string: createBaseUrl(endPoint: urlString, baseUrl: nil)) else {
            return errorHandler("Unable to create URL from given string")
        }
        
        var request = URLRequest(url: url)
        if(!headers.isEmpty){
            for (key,value) in headers{
                request.allHTTPHeaderFields?[key] = value
            }
        }
        
        print("\n date : \(Date()) urlRequest \(String(describing: request.url)) \n\n")
        request.timeoutInterval = 90
        AF.request(request).responseData(completionHandler: completionHandler)
    }

        
    
     //MARK:- POST API
    
    open func post<T: Encodable,F:Decodable>(endPoint: String,
                                             body: T,
                                             headers: [String: String] = [:],
                                             successHandler: @escaping (F) -> Void,
                                             errorHandler: @escaping ErrorHandlerAlamofire) {
        
        
        checkForNetworkConnection(errorHandler: errorHandler)

        let completionHandler: NetworkCompletionHandlerAlamofire = { (DataResponse) in
            self.genericResponseParsing(DataResponse: DataResponse, successHandler: successHandler, errorHandler: errorHandler)
        }
        
        
        guard let url = URL(string: createBaseUrl(endPoint: endPoint, baseUrl: nil)) else {
            return errorHandler("Unable to create URL from given string")
        }
        var request = URLRequest(url: url)
        request.timeoutInterval = 160
        request.httpMethod = "POST"
        request.allHTTPHeaderFields?["Content-Type"] = "application/json"
        if(!headers.isEmpty){
            for (key,value) in headers{
                request.allHTTPHeaderFields?[key] = value
            }
        }
        
        guard let data = try? JSONEncoder().encode(body) else {
            return errorHandler("Cannot encode given object into Data")
        }
        print("\n Httpbody: \(String(data: data, encoding: .utf8) ?? "No BODY")  \n\n")
        
        request.httpBody = data
        print("\n date : \(Date()) urlRequest \(String(describing: request.url)) \n\n")
        AF.request(request).responseData(completionHandler: completionHandler)
    }
    
    func genericResponseParsing<F: Decodable>(DataResponse :(AFDataResponse<Data>),successHandler: @escaping (F) -> Void, errorHandler: @escaping ErrorHandlerAlamofire)
    {
        if let error = DataResponse.error
        {
                errorHandler(error.localizedDescription)
                return
            }
        
            if let data =  DataResponse.data , let jsonString = String(data: data, encoding: .utf8)
            {
               print("API response for URL \(String(describing: DataResponse.request?.url)) => \(jsonString)")
            }
    
        
            if self.isAuthenticationInvalid(DataResponse.response)
            {
                print("\n refresh Token Expired log out")
                
                if let req = DataResponse.request, let url = req.url
                {
                }
                errorHandler(NetworkLayerAlamofire.invalidLogin)
                return
            }
            
            if self.isUnAutheriseErrorCode(DataResponse.response)
            {
                print("\n Invalid Access Token")
                return
            }
            
            
            if self.isSuccessCode(DataResponse.response)
            {
                guard let data = DataResponse.data else
                {
                     print("\n Unable to parse given type \(F.self)")
                    return errorHandler(NetworkLayerAlamofire.parsingError)
                }
                   
                if let responseObject = try? JSONDecoder().decode(F.self, from: data)
                {
                    successHandler(responseObject)
                    return
                }
            
                errorHandler(NetworkLayerAlamofire.genericError)
                return
            }
            
            if self.isSuccessWithErrorCode(DataResponse.response)
            {
                guard let data = DataResponse.data else {
                    print("\n Unable to parse Success with Error given type \(F.self)")
                    return errorHandler(NetworkLayerAlamofire.parsingError)
                }
                if let responseObject = try? JSONDecoder().decode(ResponseError.self, from: data)
                {
                    print("\n" + (responseObject.message ?? "Server not responding"))
                    errorHandler(responseObject.message ?? "Server not responding.Please try after some time.")
                    return
                }
            }

            errorHandler(NetworkLayerAlamofire.genericError)
    }
    
    //MARK:- Response Parsing
    //MARK:- Invalid access token code

     func isUnAutheriseErrorCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isUnAutheriseErrorCode(urlResponse.statusCode)
    }
   
     func isUnAutheriseErrorCode(_ statusCode: Int) -> Bool {
        return statusCode == 401
    }
    
    
    //MARK:- Invalid refresh token code
     func isAuthenticationInvalid(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isAuthenticationInvalid(urlResponse.statusCode)
    }
    
    fileprivate func isAuthenticationInvalid(_ statusCode: Int) -> Bool {
        return statusCode == 400
    }
    
    
    //MARK:- Success code
     func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
    
    
     func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
    
    //MARK:- Success code with error
     func isSuccessWithErrorCode(_ statusCode: Int) -> Bool
     {
        return statusCode >= 402 && statusCode < 500
    }
  
     func isSuccessWithErrorCode(_ response: URLResponse?) -> Bool
     {
        guard let urlResponse = response as? HTTPURLResponse else
        {
            return false
        }
        return isSuccessWithErrorCode(urlResponse.statusCode)
    }
}

