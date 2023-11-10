//
//  HeaderCell.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import UIKit

class HeaderCell: UICollectionViewCell {

    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var container: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        container.addShadow(cornerRadius: 15)
    }
    
    func setSelectedCell() {
        container.backgroundColor = .Title
        tagLabel.textColor = .white
    }
    
    func setDeselectCell() {
        container.backgroundColor = .white
        tagLabel.textColor = .Title
    }
}
