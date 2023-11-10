//
//  TrackServiceView.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import UIKit

class TrackServiceView: UIView {

    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var container: UIView!
    @IBOutlet var contentView: UIView!
    
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
        Bundle.main.loadNibNamed("TrackServiceView", owner: self, options: nil)
        
        addSubview(contentView)
        contentView.clipsToBounds = false
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentView.backgroundColor = .clear
        
        container.backgroundColor = .white
        container.addShadow(cornerRadius: 16.0)
    }

}
