//
//  FlightDetaik.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 19/02/21.
//

import UIKit

class FlightDetail: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var sourceLBL: UILabel!
    @IBOutlet weak var destinationLBL: UILabel!
    @IBOutlet weak var airlineLogo: UIImageView!
    
    @IBOutlet weak var departTime: UILabel!
    @IBOutlet weak var durationLBL: UILabel!
    @IBOutlet weak var flightNumLBL: UILabel!
    @IBOutlet weak var priceLBL: UILabel!
    
    var flightInfo : FlightQuote?
    var bookingViewModel : BookingViewModel?
    
    var iataCode:String?{
        didSet{
            let randNum = Int.random(in: 1000...9999)
            let flightNum = "\(iataCode!)\(randNum)"
            flightNumLBL.attributedText = bookingViewModel?.getDepartAttribString(align: "Right", str1: "Flight No.",
                                                                                  str2: flightNum, str1Color: Constants.titleColor!,
                                                                                  str2Color: Constants.textColor!, str1Font: ProjectFont.medium(14.0).customFont,
                                                                                  str2Font: ProjectFont.medium(16.0).customFont, nextLine: true)
        }
    }
    
    var quote: Quotes?{
        didSet{
            self.layer.cornerRadius = 20.0
            
            if let carriers = quote?.outboundLeg?.carrierIds?.first{
                if let airlineCode = flightInfo?.carriers?.filter({$0.carrierId == carriers}).first?.name?.getAirlineCode(){
//                    let url = "https://pics.avs.io/200/200/\(airlineCode).png"
                    let url = "https://daisycon.io/images/airline/?width=200&height=200&iata=\(airlineCode)"
                    iataCode = airlineCode
                    airlineLogo.imageFromServerURL(url, placeHolder: nil)
                }
            }
            
            
            if let source = quote?.outboundLeg?.originId{
                if let sourceAirportData = flightInfo?.places?.filter({$0.placeId == source}).first{
                    let attribString = bookingViewModel?.getAttributedString(spacing: 5.5, sender: "Source", placeName: sourceAirportData.cityName!, cityId: sourceAirportData.iataCode!)
                    sourceLBL.attributedText = attribString
                }
            }
            
            
            if let destination = quote?.outboundLeg?.destinationId{
                if let destionationAirportData = flightInfo?.places?.filter({$0.placeId == destination}).first{
                    let attribString = bookingViewModel?.getAttributedString(spacing: 5.5, sender: "Destination", placeName: destionationAirportData.cityName!, cityId: destionationAirportData.skyscannerCode!)
                    destinationLBL.attributedText = attribString
                }
            }
            
            if let price = quote?.minPrice{
                
                let priceVal = bookingViewModel?.getDepartAttribString(align: "left", str1: " \u{20B9}\(price)  ",
                                                                       str2: "Ticket Price", str1Color: Constants.secondaryColor!,
                                                                       str2Color: Constants.titleColor!, str1Font: ProjectFont.bold(20.0).customFont,
                                                                       str2Font: ProjectFont.medium(15.0).customFont, nextLine: false)
                priceLBL.attributedText = priceVal
            }
            
            
            departTimeValue = ""
        }
    }
    
    var departTimeValue: String?{
        didSet{
            let randNum = Int.random(in: 1...9)
            if let departure = Date().add(component: .hour, value: randNum)?.toString(format: "hh:mm a"){
                
                
                departTime.attributedText = bookingViewModel?.getDepartAttribString(align: "left", str1: "Depart",
                                                                                    str2: departure, str1Color: Constants.titleColor!,
                                                                                    str2Color: Constants.textColor!, str1Font: ProjectFont.medium(14.0).customFont,
                                                                                    str2Font: ProjectFont.medium(16.0).customFont, nextLine: true)
                
                durationLBL.text = "\(Int.random(in: 2...24)) h \(Int.random(in: 5...55)) m"
            }
        }
    }
    
}
