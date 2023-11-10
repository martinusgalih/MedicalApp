//
//  SpaceView.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import Foundation
import UIKit

public final class SpaceView: UIView {
    public convenience init(_ height: CGFloat,
                     backgroundColor: UIColor = .white) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height)
        ])
        self.backgroundColor = backgroundColor
    }
}

public final class BorderView: UIView {
    public convenience init(_ height: CGFloat,
                        backgroundColor: UIColor = .lightGray,
                     horizontalPadding: CGFloat = 0.0) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        let spacer = SpaceView(height, backgroundColor: backgroundColor)
        addSubview(spacer)
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: height),
            spacer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalPadding),
            spacer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalPadding),
            spacer.topAnchor.constraint(equalTo: topAnchor),
            spacer.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
