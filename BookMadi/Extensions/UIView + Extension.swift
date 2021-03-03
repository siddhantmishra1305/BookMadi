//
//  UIView + Extension.swift
//  BookMadi
//
//  Created by Siddhant Mishra on 08/02/21.
//

import Foundation
import UIKit
import Lottie

extension UIView{
//    func addLine(type:Int)// pass button object as a argument
//    {
//        var length = self.bounds.width
//        var x = self.bounds.origin.x
//
//        if type == 1{
//            length = length - 15
//        }else if type == 2{
//            x = x - 18
//        }
//
//        let y = self.bounds.origin.y + self.bounds.height + 5
//        let path = UIBezierPath()
//        path.move(to: CGPoint(x: x, y: y))
//        path.addLine(to: CGPoint(x: x + length , y:y))
//        //design path in layer
//        let lineLayer = CAShapeLayer()
//        lineLayer.path = path.cgPath
//        lineLayer.strokeColor = Constants.nonSelectedColor?.cgColor
//        lineLayer.lineWidth = 0.5
//        lineLayer.fillColor  = UIColor.clear.cgColor
//        self.layer.insertSublayer(lineLayer, at: 0)
//    }
    
    func activityStartAnimating(activityColor: UIColor, backgroundColor: UIColor) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        backgroundView.backgroundColor = backgroundColor
        backgroundView.tag = 475647

        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 550, height: 550))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = Constants.primaryColor
        activityIndicator.startAnimating()
        self.isUserInteractionEnabled = false

        backgroundView.addSubview(activityIndicator)

        self.addSubview(backgroundView)
    }

    func activityStopAnimating() {
        if let background = viewWithTag(475647){
            background.removeFromSuperview()
        }
        self.isUserInteractionEnabled = true
    }
    
    func addLine(length:CGFloat,color:UIColor,width:CGFloat)->CAShapeLayer
    {
        let x  = self.bounds.origin.x
        let y = self.bounds.origin.y + self.bounds.height + 5
        let path = UIBezierPath()
        path.move(to: CGPoint(x: x, y: y))
        path.addLine(to: CGPoint(x: x + length , y:y))
        //design path in layer
        let lineLayer = CAShapeLayer()
        lineLayer.path = path.cgPath
        lineLayer.strokeColor = color.cgColor
        lineLayer.lineWidth = width
        lineLayer.fillColor  = UIColor.clear.cgColor
        
        self.layer.insertSublayer(lineLayer, at: 0)
        return lineLayer
    }
    
    
    
}
