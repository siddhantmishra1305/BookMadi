//
//  RequestRouter.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 04/02/21.
//

import Foundation
import Alamofire

internal enum ServerRequestRouter:URLRequestConvertible{
    
    static var baseURL:String{
        return "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/"
    }
    
    static var localSettings:String{
        return "/v1.0/IN/INR/en-IN/"
    }
    
    
    case getPlaces(String)
    case getFlightQuotes(FlightQuoteRequest)
    
    
    var path:String{
        switch self {
        case .getPlaces(_):
            return "\(ServerRequestRouter.baseURL)autosuggest\(ServerRequestRouter.localSettings)"
            
        case .getFlightQuotes(let place):
            return "\(ServerRequestRouter.baseURL)browsedates\(ServerRequestRouter.localSettings)\(place.source)/\(place.destination)/\(place.departDate)"
        }
    }
    
    var httpMethod:HTTPMethod{
        switch self{
        case .getPlaces(_):
            return .get
            
        case .getFlightQuotes(_):
            return .get
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let URL = Foundation.URL(string: path)!
        var mutableURLRequest = URLRequest(url: URL)
        mutableURLRequest.httpMethod = httpMethod.rawValue
        
        mutableURLRequest.setValue("d104cf1983mshf9c42424657e497p168e11jsn4a67213796a2", forHTTPHeaderField: "x-rapidapi-key")
        mutableURLRequest.setValue("skyscanner-skyscanner-flight-search-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        
        switch self{
        
        case .getPlaces(let place):
            do{
                var params = [String:Any]()
                params["query"] = place
                
                let encoding = URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: params)
                
            } catch {
                return mutableURLRequest
            }
            
        case .getFlightQuotes(_):
            do{
                
                let encoding = URLEncoding(destination: URLEncoding.Destination.queryString)
                return try encoding.encode(mutableURLRequest, with: nil)
                
            } catch {
                return mutableURLRequest
            }
        }
    }
}
