//
//  WelcomeHeaderCellViewModel.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import Foundation

final class WelcomeHeaderCellViewModel: CellInterface {
    var title: String
    var subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}
