//
//  InputFieldCellViewModel.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import Foundation
import UIKit

final class InputFieldCellViewModel: CellInterface {
    var title: String
    var placeHolder: String
    var type: CustomTextField.Style
    private var _value: String = .emptyString
    var value: String {
        set {
            _value = newValue
        }
        get {
            return _value
        }
    }
    var onTextChange: ((UITextField, String) -> Bool)? = nil
    
    init(type: CustomTextField.Style,
         title: String = .emptyString,
         placeHolder: String) {
        self.type = type
        self.title = title
        self.placeHolder = placeHolder
    }
}
