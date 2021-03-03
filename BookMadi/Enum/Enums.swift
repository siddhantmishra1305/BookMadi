//
//  Enum.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 06/02/21.
//

import Foundation
import UIKit

enum FlightClassType:String,CaseIterable{
    case Economy
    case Business
    case Elite
    
    
    var icon:UIImage{
        switch self {
        case .Economy:
            return UIImage(named: "Economy")!
        case .Business:
            return UIImage(named: "Business")!
        case .Elite:
            return UIImage(named: "Elite")!
        }
    }
    
    var seats:Int{
        switch self {
        case .Economy:
            return 36
            
        case .Business:
            return 24
            
        case .Elite:
            return 16
        }
    }
    
//    static let allValues = ["Economy", "Business", "Elite"]
}

enum ProjectFont{
    
    case regular(CGFloat)
    case medium(CGFloat)
    case bold(CGFloat)
    
    
    var customFont:UIFont{
        switch self {
        case .regular(let size):
            return UIFont(name: "HelveticaNeue", size: size)!
            
        case .medium(let size):
            return UIFont(name: "HelveticaNeue-medium", size: size)!
            
        case .bold(let size):
            return UIFont(name: "HelveticaNeue-bold", size: size)!
            
        }
    }
}
