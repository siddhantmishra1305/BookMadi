//
//  FlightClassCell.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 06/02/21.
//

import UIKit

class FlightClassCell: UICollectionViewCell {

    @IBOutlet weak var flightClassImg: UIImageView!
    
    @IBOutlet weak var flightClasslbl: UILabel!
    
    var addTint : Bool!{
        didSet{
            if addTint{
                flightClasslbl.textColor = Constants.nonSelectedColor
                flightClassImg.tintColor = Constants.nonSelectedColor
            }else{
                flightClasslbl.textColor = Constants.textColor
                flightClassImg.tintColor = Constants.textColor
            }
        }
    }
    
    var flightType:String?{
        didSet{
            let data = FlightClassType(rawValue: flightType!)
            flightClasslbl.text = flightType
            flightClassImg.image = data?.icon
        }
    }
}
