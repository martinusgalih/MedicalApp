//
//  InfoHealthView.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

class InfoHealthView: UIView {

    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var container: UIView!
//    @IBOutlet weak var buttonView: CustomButton!
    @IBOutlet var contentView: UIView!
    
    private lazy var buttonView: CustomButton = {
        CustomButton()
    }()
    
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
        Bundle.main.loadNibNamed("InfoHealthView", owner: self, options: nil)
        
        addSubview(contentView)
        contentView.clipsToBounds = false
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentView.backgroundColor = .clear
        
        container.backgroundColor = .white
        container.addShadow(radius: 5, cornerRadius: 16.0)
        
        stackContainer.addArrangedSubview(buttonView)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        buttonView.heightAnchor.constraint(equalToConstant: 32.0).isActive = true
        buttonView.setTitle(title: " Selengkapnya ")
        buttonView.setFontSize(size: 12.0)
        buttonView.cornerRadius = 8.0
    }

}
