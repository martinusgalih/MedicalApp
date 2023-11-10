//
//  WelcomeHeaderCell.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

class WelcomeHeaderCell: UITableViewCell {
    private lazy var welcomeView: WelcomeView = {
        WelcomeView()
    }()
    
    var viewModel: WelcomeHeaderCellViewModel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        welcomeView.removeFromSuperview()
        viewModel = nil
    }
}

extension WelcomeHeaderCell {
    func bind(_ viewModel: WelcomeHeaderCellViewModel) {
        self.viewModel = viewModel
        assignValue()
        attachViews()
    }
}

private extension WelcomeHeaderCell {
    func assignValue() {
        welcomeView.titleLabel.text = viewModel.title
        welcomeView.descriptionLabel.text = viewModel.subtitle
    }
    
    func attachViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(welcomeView)
        NSLayoutConstraint.activate([
            welcomeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            welcomeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            welcomeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            welcomeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
