//
//  Constants.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 06/02/21.
//

import Foundation
import UIKit


struct Constants{
    
    //MARK: App Colors
    static let primaryColor = UIColor(named: "PrimaryColor")
    static let secondaryColor = UIColor(named: "SecondaryColor")
    static let textColor = UIColor(named: "TextColor")
    static let titleColor = UIColor(named: "Title")
    static let selectedSeat = UIColor(named: "SelectedSeat")
    static let whiteOpaque = UIColor(named: "WhiteOpaque")
    static let nonSelectedColor = UIColor(named: "NonSelectedColor")
    static let CalendarCellBorderColor = UIColor(named: "CalendarBorderColor")
    
    static let numOfAdults = ["1","2","3","4","5","6","7","8","9","10"]
    static let numOfKids = ["0","1","2","3","4","5"]
    static let numOfBags = ["0","1","2","3","4","5","6"]
    
    static let serverFormat = "yyyy-MM-dd"
    static let uiFormat = "yyyy/MM/dd"
    //MARK: Observer Keypath
    static let btnTitleKey = "titleLabel.text"
    static let imageBaseURL = "https://daisycon.io/images/airline/?width=200&height=200&color=ffffff&iata="
}
