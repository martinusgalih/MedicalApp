//
//  UIView+extension.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

extension UIView {
    func addConstraintFitToSuperview(top: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil, bottom: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            if top == nil && left == nil && right == nil && bottom == nil && width == nil && height == nil {
                topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
                leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
                rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
                bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
                return
            }
            
            if let top = top {
                topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
            }
            if let left = left {
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: left).isActive = true
            }
            if let width = width {
                widthAnchor.constraint(equalToConstant: width).isActive = true
            }
            if let right = right {
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: right).isActive = true
            }
            if let height = height {
                heightAnchor.constraint(equalToConstant: height).isActive = true
            }
            if let bottom = bottom {
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: bottom).isActive = true
            }
        }
    }
}

extension UIView {

    /**
     Rounds the given set of corners to the specified radius

     - parameter corners: Corners to round
     - parameter radius:  Radius to round to
     */
    func round(corners: UIRectCorner, radius: CGFloat) {
        _ = _round(corners: corners, radius: radius)
    }

    /**
     Rounds the given set of corners to the specified radius with a border

     - parameter corners:     Corners to round
     - parameter radius:      Radius to round to
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func round(corners: UIRectCorner, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        let mask = _round(corners: corners, radius: radius)
        addBorder(mask: mask, borderColor: borderColor, borderWidth: borderWidth)
    }

    /**
     Fully rounds an autolayout view (e.g. one with no known frame) with the given diameter and border

     - parameter diameter:    The view's diameter
     - parameter borderColor: The border color
     - parameter borderWidth: The border width
     */
    func fullyRound(diameter: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = diameter / 2
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
    }

}

// MARK: - Drop Shadow
extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.07
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 32
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

private extension UIView {

    @discardableResult func _round(corners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
        return mask
    }

    func addBorder(mask: CAShapeLayer, borderColor: UIColor, borderWidth: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }

}
