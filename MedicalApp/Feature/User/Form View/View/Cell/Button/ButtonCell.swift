//
//  ButtonCell.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

public final class ButtonCellViewModel: CellInterface {
    var title: String
    var didClickButton: (() -> Void)? = nil
    init(title: String) {
        self.title = title
    }
}

public class ButtonCell: UITableViewCell {
    private lazy var buttonCustom: CustomButton = {
        CustomButton()
    }()
    
    var viewModel: ButtonCellViewModel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        buttonCustom.removeFromSuperview()
        viewModel = nil
    }
}


extension ButtonCell {
    func bind(_ viewModel: ButtonCellViewModel) {
        self.viewModel = viewModel
        attachViews()
        buttonCustom.didClickButton = { [ weak self ] in
            self?.viewModel.didClickButton?()
        }
    }
}

private extension ButtonCell {
    func attachViews() {
        buttonCustom.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        contentView.addSubview(buttonCustom)
        NSLayoutConstraint.activate([
            buttonCustom.topAnchor.constraint(equalTo: contentView.topAnchor),
            buttonCustom.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            buttonCustom.heightAnchor.constraint(equalToConstant: 48.0),
            buttonCustom.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            buttonCustom.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
        ])
        
        buttonCustom.setTitle(title: viewModel.title)
    }
}
