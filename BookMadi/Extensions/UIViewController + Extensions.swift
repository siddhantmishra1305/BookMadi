//
//  UIViewController + Extensions.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 28/02/21.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
