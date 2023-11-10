//
//  SearchBar.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import UIKit

class SearchBar: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var searchTextField: UITextField! {
        didSet {
            searchTextField.placeholder = "Search"
            searchTextField.textColor = .Title
            searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        }
    }
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var filterView: UIView!
    
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
        Bundle.main.loadNibNamed("SearchBar", owner: self, options: nil)
        
        addSubview(contentView)
        contentView.clipsToBounds = false
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentView.backgroundColor = .clear
        
        setup()
    }
    
    func setup() {
        searchTextField.addDoneButtonOnKeyboard {[weak self] in
            self?.searchTextField.endEditing(true)
        }
        
        filterView.backgroundColor = .white
        searchContainer.backgroundColor = .white
        
        filterView.addShadow(cornerRadius: 20.0)
        searchContainer.addShadow(cornerRadius: 20.0)
    }

    
}
