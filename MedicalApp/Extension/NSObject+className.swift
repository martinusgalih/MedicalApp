//
//  NSObject+className.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import Foundation

extension NSObject {
    static func className() -> String {
        return String(describing: self)
    }
}
