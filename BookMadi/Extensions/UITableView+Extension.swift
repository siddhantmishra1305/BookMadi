//
//  UITableView+Extension.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 08/02/21.
//

import Foundation
import UIKit

extension UITableView {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .large)
            self.backgroundView = activityView
            activityView.startAnimating()
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.backgroundView = nil
        }
    }
}
