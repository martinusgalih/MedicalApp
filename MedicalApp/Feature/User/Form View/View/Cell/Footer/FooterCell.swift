//
//  FooterCell.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

public final class FooterCellViewModel: CellInterface {
}

public class FooterCell: UITableViewCell {
    private lazy var footerView: FooterView = {
        FooterView()
    }()
    
    var viewModel: FooterCellViewModel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        footerView.removeFromSuperview()
        viewModel = nil
    }
}


extension FooterCell {
    func bind(_ viewModel: FooterCellViewModel) {
        self.viewModel = viewModel
        attachViews()
    }
}

private extension FooterCell {
    func attachViews() {
        contentView.backgroundColor = .white
        footerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(footerView)
        NSLayoutConstraint.activate([
            footerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            footerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 20.0)
        ])
    }
}
