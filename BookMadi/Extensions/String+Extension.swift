//
//  String+Extension.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 06/02/21.
//

import Foundation

extension String{
    func getDate()->Date?{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: self)
    }
    
    func getAirlineCode()->String?{
        if let path = Bundle.main.path(forResource: "Airline", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? [[String:AnyObject]] {
                    if let code = jsonResult.filter({$0["name"] as! String == self}).first{
                        return code["code"] as? String
                    }
                }
            } catch {
                print("")
                // handle error
            }
        }
        return nil
    }
}
