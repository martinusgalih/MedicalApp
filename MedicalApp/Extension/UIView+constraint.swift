//
//  UIView+constraint.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

public extension UIView {
    func fitToSuperView(inset: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: inset.top),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: inset.right),
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: inset.left),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: inset.bottom)
        ])
    }
    
    func fitToSuperView(inset: UIEdgeInsets = .zero, view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: inset.right),
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: inset.left),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: inset.bottom)
        ])
    }
    
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottomAnchor
        }
    }

    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        } else {
            return topAnchor
        }
    }

    var safeHeightAnchor: NSLayoutDimension {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.heightAnchor
        } else {
            return heightAnchor
        }
    }

    var safeWidthAnchor: NSLayoutDimension {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.widthAnchor
        } else {
            return widthAnchor
        }
    }
}
