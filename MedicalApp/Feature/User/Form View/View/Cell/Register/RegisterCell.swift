//
//  RegisterCell.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

public final class RegisterCellViewModel: CellInterface {
    var leftLabel: String
    var rightLabel: String
    var didClickButton: (() -> Void)? = nil
    
    init(leftLabel: String, rightLabel: String) {
        self.leftLabel = leftLabel
        self.rightLabel = rightLabel
    }
}

public class RegisterCell: UITableViewCell {
    private lazy var registerLabel: CtaLabelView = {
        CtaLabelView()
    }()
    
    var viewModel: RegisterCellViewModel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        registerLabel.removeFromSuperview()
        viewModel = nil
    }
}


extension RegisterCell {
    func bind(_ viewModel: RegisterCellViewModel) {
        self.viewModel = viewModel
        attachViews()
        registerLabel.didClickButton = {
            self.viewModel.didClickButton?()
        }
    }
}

private extension RegisterCell {
    func attachViews() {
        contentView.backgroundColor = .white
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(registerLabel)
        NSLayoutConstraint.activate([
            registerLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            registerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            registerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            registerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            registerLabel.heightAnchor.constraint(equalToConstant: 20.0)
        ])
        
        self.registerLabel.setTitle(leftTitle: viewModel.leftLabel, rightTitle: viewModel.rightLabel)
    }
}
