//
//  CustomButton.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

class CustomButton: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var buttonCustom: UIButton!
    var didClickButton: (() -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("CustomButton", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentView.addShadow(cornerRadius: 8.0)
        setUp()
    }
    
    func setTitle(title: String) {
        buttonCustom.setTitle(title, for: .normal)
    }
    
    func setFontSize(size: CGFloat) {
        buttonCustom.titleLabel?.font = FontFamily.Gilroy.light.font(size: size)
    }
    
    func setUp () {
        buttonCustom.setTitleColor(.white, for: .normal)
        buttonCustom.backgroundColor = .Title
        buttonCustom.titleLabel?.font = FontFamily.Gilroy.light.font(size: 16.0)
        buttonCustom.addShadow(cornerRadius: 8.0)
        
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(self.buttonTapped(_:)))
        self.buttonCustom.isUserInteractionEnabled = true
        self.buttonCustom.addGestureRecognizer(viewTap)
    }
  
    @IBAction func buttonTapped(_ sender: UIButton) {
        didClickButton?()
    }
}
