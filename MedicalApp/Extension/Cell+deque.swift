//
//  Cell+deque.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

public extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func nib(bundle: Bundle? = nil) -> UINib {
        return UINib(nibName: reuseIdentifier, bundle: bundle)
    }
    
    static func createFromNib<T: UIView>(_ type: T.Type, bundle: Bundle? = nil) -> T {
        guard let view = type.nib(bundle: bundle).instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError("cannot create \(reuseIdentifier) from XIB")
        }
        return view
    }
}
