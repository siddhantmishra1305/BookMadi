//
//  FlightQuoteRequest.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 17/02/21.
//

import Foundation

struct FlightQuoteRequest {
    var source:String = "BLR-sky"
    var destination:String = "DEL-sky"
    var departDate:String = ""
    var returnDate:String?
    var directFlight : Bool = false
    var adults :Int = 1
    var children :Int = 0
    var luggage :Int = 0
    var ticketClass : FlightClassType = .Economy
}
