//
//  CtaLabelView.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

class CtaLabelView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var mainContainer: UIStackView!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    
    var didClickButton: (() -> Void)? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadNib() {
        Bundle.main.loadNibNamed("CtaLabelView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentView.backgroundColor = .clear
        setUp()
    }
    
    func setTitle(leftTitle: String, rightTitle: String) {
        rightLabel.text = rightTitle
        leftLabel.text = leftTitle
    }
    
    func setUp () {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(self.buttonTapped(_:)))
        self.mainContainer.isUserInteractionEnabled = true
        self.mainContainer.addGestureRecognizer(viewTap)
    }
  
    @IBAction func buttonTapped(_ sender: UIButton) {
        didClickButton?()
    }
}
