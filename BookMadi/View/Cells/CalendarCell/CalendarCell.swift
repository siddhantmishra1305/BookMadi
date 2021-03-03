//
//  CalendarCell.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 19/02/21.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    @IBOutlet weak var calendarLBL: UILabel!
    
    var cellData:Date?{
        didSet{
            let style = NSMutableParagraphStyle()
            style.alignment = .center
            style.lineBreakMode = .byWordWrapping
            
            guard
                let day = cellData?.dayofTheWeek ,
                let date = cellData?.toString(format: "dd") else { return }
            
            guard
                let medium = UIFont(name: "HelveticaNeue-Medium", size: 14),
                let light = UIFont(name: "HelveticaNeue-Medium", size: 18)  else { return }
            
            let keyAttributes: [NSAttributedString.Key: Any] = [.font:medium ,
                                                                .paragraphStyle : style]
            
            let valueAttributes: [NSAttributedString.Key: Any] = [.font: light,
                                                                  .paragraphStyle : style]
            
            let attString = NSMutableAttributedString()
            attString.append(NSAttributedString(string: day, attributes: keyAttributes))
            attString.append(NSAttributedString(string: "\n"))
            attString.append(NSAttributedString(string: date, attributes: valueAttributes))
            calendarLBL.attributedText = attString
        }
    }
    
    var selectedCell : Bool!{
        didSet{
            if selectedCell{
                backgroundColor = Constants.primaryColor
                calendarLBL.textColor = .white
                addBorderAndCornerRadius(set: false)
            }else{
                backgroundColor = .white
                calendarLBL.textColor = Constants.titleColor
                addBorderAndCornerRadius(set: true)
            }
        }
    }
    
    
    func addBorderAndCornerRadius(set:Bool){
        self.layer.cornerRadius = 10.0
        if set{
            self.layer.borderWidth = 1.5
            self.layer.borderColor = Constants.CalendarCellBorderColor?.cgColor
        }else{
            self.layer.borderWidth = 1.5
            self.layer.borderColor = UIColor.white.cgColor
        }
        
    }
    
    
    
    
    
}
