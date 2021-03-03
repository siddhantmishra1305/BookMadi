//
//  BookingViewModel.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 06/02/21.
//

import Foundation
import UIKit


class BookingViewModel {
    
    func getTitleColor(object:Any, keyPath:String)->UIColor{
        if let btn = object as? UIButton{
            if let value = Int((btn.titleLabel?.text)!){
                if value > 0 {
                    return Constants.textColor!
                }
                return Constants.nonSelectedColor!
            }
        }
        return Constants.nonSelectedColor!
    }
    
    func getAllDates(to:Date)->[Date]{
        let allDates = Date.allDates(from: Date(), to: to.add(component: .day, value: 31)!) 
        return allDates
    }
    
    func getAttributedString(spacing:CGFloat,sender:String,placeName:String, cityId:String)->NSMutableAttributedString?{
        
        let style = NSMutableParagraphStyle()
        
        if sender == "Source"{
            style.alignment = .left
        }else{
            style.alignment = .right
        }
        style.lineSpacing = spacing
        
        style.lineBreakMode = .byWordWrapping
        
        guard
            let medium = UIFont(name: "HelveticaNeue-Medium", size: 16),
            let light = UIFont(name: "HelveticaNeue-Medium", size: 14)  else { return nil}
        
        let keyAttributes: [NSAttributedString.Key: Any] = [.font:medium ,
                                                            .paragraphStyle: style,
                                                            .foregroundColor:Constants.primaryColor!]
        
        let valueAttributes: [NSAttributedString.Key: Any] = [.font: light,
                                                              .paragraphStyle: style,
                                                              .foregroundColor:Constants.primaryColor!.withAlphaComponent(0.75)]
        
        let attString = NSMutableAttributedString()
        attString.append(NSAttributedString(string: placeName , attributes: keyAttributes))
        attString.append(NSAttributedString(string: "\n"))
        attString.append(NSAttributedString(string: cityId.replacingOccurrences(of: "-sky", with: "") , attributes: valueAttributes))
        
        return attString
    }
    
    
    func getDepartAttribString(align:String,str1:String,str2:String,str1Color:UIColor,str2Color:UIColor,str1Font:UIFont,str2Font:UIFont,nextLine:Bool)->NSMutableAttributedString?{
        
        let style = NSMutableParagraphStyle()
        if align == "left"{
            style.alignment = .left
        }else{
            style.alignment = .right
        }
        style.lineSpacing = 1.2
        
        style.lineBreakMode = .byWordWrapping
        
    
        let keyAttributes: [NSAttributedString.Key: Any] = [.font:str1Font ,
                                                            .paragraphStyle: style,
                                                            .foregroundColor:str1Color]
        
        let valueAttributes: [NSAttributedString.Key: Any] = [.font: str2Font,
                                                              .paragraphStyle: style,
                                                              .foregroundColor:str2Color]
        
        let attString = NSMutableAttributedString()
        
        attString.append(NSAttributedString(string: str1 , attributes: keyAttributes))
       
        if nextLine {
            attString.append(NSAttributedString(string: "\n"))
        }
        
        attString.append(NSAttributedString(string: str2 , attributes: valueAttributes))
        
        return attString
    }
    
    
    
    func searchPlace(place:String,handler:@escaping([searchPlaces]?,ServerError?)->Void){
        ServerManager.sharedInstance.getPlace(place) { (response, error) in
            if let err = error{
                handler(nil,err)
            }else{
                handler(response,nil)
            }
        }
    }
    
    func fetchFlightPrices(request:FlightQuoteRequest,handler:@escaping(FlightQuote?,ServerError?)->Void){
        ServerManager.sharedInstance.getFlightQuotes(request) { (response, error) in
            if let err = error{
                handler(nil,err)
            }else{
                handler(response,nil)
            }
        }
    }
    
}
