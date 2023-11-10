//
//  HealthServiceView.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import UIKit

struct HealthServiceModel {
    let title: String?
    let price: String?
    let place: String?
    let location: String?
    let image: String?
}

class HealthServiceView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var imagePlace: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    
    var model: HealthServiceModel?
    init(model: HealthServiceModel) {
        self.model = model
        super.init(frame: .zero)
        self.loadNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadNib() {
        self.backgroundColor = .white
        self.clipsToBounds = false
        Bundle.main.loadNibNamed("HealthServiceView", owner: self, options: nil)
        
        addSubview(contentView)
        contentView.clipsToBounds = false
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentView.backgroundColor = .white
        contentView.addShadow(cornerRadius: 16.0)
        setupValue()
    }
    
    func setupValue() {
        nameLabel.text = model?.title
        priceLabel.text = model?.price
        buildingLabel.text = model?.place
        locationLabel.text = model?.location
        imagePlace.image = UIImage(named: model?.image ?? .emptyString)
    }
}
