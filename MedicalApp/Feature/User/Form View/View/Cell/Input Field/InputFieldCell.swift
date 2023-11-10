//
//  InputFieldCell.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

class InputFieldCell: UITableViewCell {
    private lazy var textInput: CustomTextField = {
        let text = CustomTextField()
        return text
    }()
    
    var viewModel: InputFieldCellViewModel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        textInput.removeFromSuperview()
        viewModel = nil
    }
}

extension InputFieldCell {
    func bind(_ viewModel: InputFieldCellViewModel) {
        self.viewModel = viewModel
        assignValue()
        attachViews()
    }
}

private extension InputFieldCell {
    func assignValue() {
        textInput.title = viewModel.title
        textInput.placeholder = viewModel.placeHolder
        textInput.style = viewModel.type
        textInput.textField.delegate = self
    }
    
    func attachViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(textInput)
        NSLayoutConstraint.activate([
            textInput.topAnchor.constraint(equalTo: contentView.topAnchor),
            textInput.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20.0),
            textInput.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0),
            textInput.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textInput.heightAnchor.constraint(equalToConstant: 70.0)
        ])
    }
}

// MARK: - UITextFieldDelegate
extension InputFieldCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.value = textField.text ?? .emptyString
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = ((textField.text ?? "") as NSString).replacingCharacters(in: range, with: string).filter{ $0.isASCII }
        viewModel.value = newString
        return viewModel.onTextChange?(textField, newString) ?? true
    }
}
