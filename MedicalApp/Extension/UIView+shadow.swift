//
//  UIView+shadow.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

extension UIView {
            
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func addShadow(
        color: UIColor = .black,
        opacity: Float = 0.2,
        radius: CGFloat = 2,
        cornerRadius: CGFloat = 10,
        offset: CGSize = CGSize(width: 1, height: 2),
        isStaticView: Bool = false) {
        layer.masksToBounds = false
        layer.cornerRadius = cornerRadius
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset

        if isStaticView {
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    func removeShadow(maskToBounds: Bool = true) {
        layer.shadowColor = nil
        layer.shadowOpacity = 0.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 0
        layer.cornerRadius = 0
        layer.shadowPath = nil
        layer.masksToBounds = maskToBounds
    }

}
