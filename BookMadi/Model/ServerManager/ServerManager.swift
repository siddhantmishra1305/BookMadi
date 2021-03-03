//
//  ServerManager.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 04/02/21.
//

import Foundation
import AlamofireObjectMapper
import Alamofire

public enum ServerErrorCodes: Int{
    case notFound = 404
    case validationError = 422
    case internalServerError = 500
    
}


public enum ServerErrorMessages: String{
    case notFound = "Not Found"
    case validationError = "Validation Error"
    case internalServerError = "Internal Server Error"
}


public enum ServerError: Error{
    case systemError(Error)
    case customError(String)
    
    public var details:(code:Int ,message:String){
        switch self {
        
        case .customError(let errorMsg):
            switch errorMsg {
            case "Not Found":
                return (ServerErrorCodes.notFound.rawValue,ServerErrorMessages.notFound.rawValue)
            case "Validation Error":
                return (ServerErrorCodes.validationError.rawValue,ServerErrorMessages.validationError.rawValue)
            case "Internal Server Error":
                return (ServerErrorCodes.internalServerError.rawValue,ServerErrorMessages.internalServerError.rawValue)
            default:
                return (ServerErrorCodes.internalServerError.rawValue,ServerErrorMessages.internalServerError.rawValue)
            }
            
        case .systemError(let errorCode):
            return (errorCode._code,errorCode.localizedDescription)
        }
    }
}

public struct ServerManager{
    
    static let sharedInstance = ServerManager()
    
    func getPlace(_ place:String,handler:@escaping ([searchPlaces]?,ServerError?) -> Void){
        
        Alamofire.request(ServerRequestRouter.getPlaces(place)).validate().responseObject { (response:DataResponse<SearchPlaceResponse>) in
            
            switch response.result{
            
            case .success:
                if let resp = response.result.value{
                    handler(resp.places,nil)
                }
                
            case .failure(let error):
                print(error)
                if error.localizedDescription .contains("404"){
                    handler(nil,ServerError.customError("Not Found"))
                } else if error.localizedDescription.contains("422") {
                    handler(nil,ServerError.customError("Validation Error"))
                } else if error.localizedDescription.contains("500"){
                    handler(nil,ServerError.customError("Internal Server Error"))
                }
                else{
                    handler(nil,ServerError.systemError(error))
                }
            }
        }
    }
    
    func getFlightQuotes(_ place:FlightQuoteRequest,handler:@escaping (FlightQuote?,ServerError?) -> Void){
        
        Alamofire.request(ServerRequestRouter.getFlightQuotes(place)).validate().responseObject { (response:DataResponse<FlightQuote>) in

            switch response.result{

            case .success:
                if let resp = response.result.value{
                    handler(resp,nil)
                }

            case .failure(let error):
                print(error)
                if error.localizedDescription .contains("404"){
                    handler(nil,ServerError.customError("Not Found"))
                } else if error.localizedDescription.contains("422") {
                    handler(nil,ServerError.customError("Validation Error"))
                } else if error.localizedDescription.contains("500"){
                    handler(nil,ServerError.customError("Internal Server Error"))
                }
                else{
                    handler(nil,ServerError.systemError(error))
                }
            }
        }
    }
}
