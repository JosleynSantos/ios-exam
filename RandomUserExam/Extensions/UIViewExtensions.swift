//
//  UIViewExtensions.swift
//  RandomUserExam
//
//  Created by Josleyn Santos on 11/29/21.
//

import UIKit

extension UIView {
    func dropShadowWithRoundedCorners(){
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 6
        layer.masksToBounds = false
        layer.cornerRadius = 10
    }
    
    func setRoundedCorners(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        contentMode = .scaleAspectFill
        clipsToBounds = true
    }
}
