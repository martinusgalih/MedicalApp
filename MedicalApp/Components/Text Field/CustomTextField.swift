//
//  CustomTextField.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

final class CustomTextField: UIView {
    public var didClickAction: (() -> Void)?
    public var onTextChange: ((String) -> Void)?
    public var didTextChange: (() -> Void)?
    var onErrorChange: ((Bool) -> ())?
    
    private let rightImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 20))
    private let verticalStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let dummyStack = UIStackView(frame: CGRect.zero)
    private let stackView = UIStackView(frame: CGRect.zero)
    
    lazy var containerView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.addShadow(cornerRadius: 8.0)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Gilroy.light.font(size: 16)
        label.textColor = .Title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = FontFamily.Gilroy.light.font(size: 12)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var textField = UITextField(frame: .zero)
    
    private var _minimumCharacter: Int = .zero
    
    @IBInspectable
    var minimumCharacter: Int {
        get {
            return _minimumCharacter
        }
        set {
            _minimumCharacter = newValue
            configureView(style)
            updateView()
        }
    }
    
    var text: String? {
        get {
            return textField.text
        }
        set {
            textField.text = newValue
        }
    }
    
    @IBInspectable
    var type: Int {
        get {
            return style.rawValue
        }
        set {
            style = Style(rawValue: newValue) ?? .default
            configureView(style)
            updateView()
        }
    }
    
    var style: Style = .default {
        didSet {
            updateView()
        }
    }
    
    fileprivate lazy var pickerView: UIPickerView = {
        UIPickerView()
    }()
    
    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneAction))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        return toolbar
    }()
    
    @objc private func doneAction() {
        endEditing(true)
    }
    
    let options = Array(1...100).map { "\($0)" }

    
    enum Style: Int {
        case `default` = 1
        case phoneNumber = 2
        case email = 3
        case password = 4
    }
    
    @IBInspectable
    var title: String {
        get {
            return titleLabel.text ?? .emptyString
        }
        set {
            titleLabel.text = newValue
            titleLabel.isHidden = newValue.isEmpty
            configureView(style)
            updateView()
        }
    }
    
    @IBInspectable
    var error: String? {
        get {
            return errorLabel.text
        }
        set {
            errorLabel.text = newValue
            configureView(style)
            updateView()
        }
    }
    
    private var _isChecklistIconShown: Bool = false
    @IBInspectable
    var isChecklistIconShown: Bool {
        get {
            return _isChecklistIconShown
        }
        set {
            _isChecklistIconShown = newValue
            configureView(style)
            updateView()
        }
    }
    
    @IBInspectable
    var isEnable: Bool {
        get {
            return textField.isEnabled
        }
        set {
            textField.isEnabled = newValue
            updateView()
        }
    }
    
    var keyboardType: UIKeyboardType {
        get {
            textField.keyboardType
        }
        set {
            textField.keyboardType = newValue
        }
    }
    
    @IBInspectable
    var placeholder: String? {
        get {
            textField.placeholder
        }
        set {
            textField.placeholder = newValue
            textField.attributedPlaceholder = NSAttributedString(string: newValue ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    
    init(style: Style = .default,
         placeHolder: String? = nil,
         title: String? = nil) {
        super.init(frame: .zero)
        self.style = style
        self.placeholder = placeHolder
        configureView(style)
        updateView()
    }
    
    init(type: CustomTextField.Style,
         title: String = .emptyString,
         placeholder: String? = nil,
         keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        self.style = type
        self.title = title
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        configureView(style)
        updateView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView(style)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView(style)
    }
    
    func showError(isShow: Bool) {
        onErrorChange?(!isShow)
        if error?.isEmpty == true {
            errorLabel.removeFromSuperview()
            return
        }
        errorLabel.isHidden = false
        if isShow {
            verticalStackView.addArrangedSubview(errorLabel)
        } else {
            errorLabel.removeFromSuperview()
        }
    }
}

private extension CustomTextField {
    func configureView(_ style: Style) {
        
        self.autoresizesSubviews = true
        self.clipsToBounds = false
        self.isOpaque = true
        self.backgroundColor = .white
        
        textField.addDoneButtonOnKeyboard {[weak self] in
            self?.textField.endEditing(true)
        }
        
        addStackView()
        addTextField()
    }
    
    func updateView() {
        switch style {
            case .phoneNumber:
                imageView.isHidden = true
            case .email:
                imageView.isHidden = true
            case .password:
                imageView.isHidden = true
                textField.isSecureTextEntry = true
            default:
                imageView.isHidden = true
        }
    }
    
    func addStackView() {
        verticalStackView.removeAllArrangedSubviews()
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(verticalStackView)
        verticalStackView.fitToSuperView()
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 40).isActive = true
        
        if title.isEmpty {
            titleLabel.removeFromSuperview()
        }
        
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
        
        stackView.fitToSuperView(inset: .init(top: .zero, left: 16.0, bottom: .zero, right: -16.0),view: containerView)
    }
    
    func addTextField() {
        stackView.backgroundColor = .clear
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.addArrangedSubview(imageView)
        
        textField.returnKeyType = UIReturnKeyType.done
        textField.autocapitalizationType = (keyboardType == UIKeyboardType.emailAddress) ? .none : .sentences
        textField.font = FontFamily.ProximaNova.regular.font(size: 12.0)
        textField.borderStyle = .none
        textField.textColor = .Grey_5F5F5F
        textField.tintColor = .black
        textField.attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.placeholder = placeholder
        textField.backgroundColor = .clear
        textField.textAlignment = .left
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.axis = .horizontal
        stackView.addArrangedSubview(textField)
        switch style {
            case .email:
                textField.keyboardType = .emailAddress
            case .phoneNumber:
                textField.keyboardType = .phonePad
            default:
                stackView.axis = .horizontal
        }
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textField.layer.borderColor = UIColor.clear.cgColor
        containerView.layer.borderWidth = .zero
        containerView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        didTextChange?()
        if textField.text?.count ?? .zero < minimumCharacter {
            self.showError(isShow: true)
            if style == .phoneNumber {
                self.textField.layer.borderColor = #colorLiteral(red: 0.8071616888, green: 0, blue: 0.02321808226, alpha: 1)
                return
            }
            self.containerView.layer.borderColor = #colorLiteral(red: 0.8071616888, green: 0, blue: 0.02321808226, alpha: 1)
        } else {
            self.showError(isShow: false)
            if style == .phoneNumber {
                self.textField.layer.borderColor = UIColor.Title.cgColor
                return
            }
            self.containerView.layer.borderColor = UIColor.Title.cgColor
        }
        
        if style == .email {
            if textField.text?.isValidEmail ?? false {
                self.showError(isShow: false)
                self.containerView.layer.borderColor = UIColor.Title.cgColor
            } else {
                self.showError(isShow: true)
                self.containerView.layer.borderColor = #colorLiteral(red: 0.8071616888, green: 0, blue: 0.02321808226, alpha: 1)
            }
        }
        
        if style == .password {
            if  textField.text?.isValidPassword() == true {
                self.showError(isShow: false)
                self.containerView.layer.borderColor = UIColor.Title.cgColor
            } else {
                self.showError(isShow: true)
                self.containerView.layer.borderColor = #colorLiteral(red: 0.8071616888, green: 0, blue: 0.02321808226, alpha: 1)
            }
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.style == .phoneNumber, !string.isEmpty {
            let set = CharacterSet(charactersIn: "1234567890")
            var isValid = true
            string.forEach { (char) in
                if isValid, "\(char)".rangeOfCharacter(from: set) == nil {
                    isValid = false
                }
            }
            if !isValid {
                return false
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        containerView.layer.borderColor = UIColor.Title.cgColor
        containerView.layer.borderWidth = 1
    }
}

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let test1 = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[A-Z])(?=.*[!@#$&{}'<,>.?/;:~\"|\\^\\-\\_\\+\\=\\(\\)\\[\\]|\\\\*])(?=.*[0-9])(?=.*[a-z]).{8,16}$").evaluate(with: self)

        if test1 == true {
            return true
        } else {
            return false
        }
    }
}
