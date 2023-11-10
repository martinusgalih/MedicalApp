//
//  WelcomeView.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

class WelcomeView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Gilroy.extraBold.font(size: 28.0)
        label.text = "Hai, Selamat Datang"
        label.textColor = ._1D334F
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.ProximaNova.regular.font(size: 12.0)
        label.text = "Silahkan login untuk melanjutkan"
        label.textColor = ._1D334F
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var illustrationImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = ImageAsset.Image.illustrationBanner.image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
}

private extension WelcomeView {
    func setup() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(illustrationImage)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -4.0)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            illustrationImage.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor),
            illustrationImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 25.0),
            illustrationImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            illustrationImage.heightAnchor.constraint(equalToConstant: 218.0)
        ])
        
        self.sendSubviewToBack(illustrationImage)
    }
}
