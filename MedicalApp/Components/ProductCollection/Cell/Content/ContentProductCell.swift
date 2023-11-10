//
//  ContentProductCell.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import UIKit

class ContentProductCell: UICollectionViewCell {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()
        container.addShadow(opacity: 0.01,radius: 0.05, cornerRadius: 16, offset: CGSize(width: 0.1, height: 0.1))
    }
}
