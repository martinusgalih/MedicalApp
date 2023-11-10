//
//  SettingsViewController.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import UIKit
import IHKeyboardAvoiding

class SettingsViewController: UIViewController {

    @IBOutlet weak var formViewContainer: UIView! {
        didSet {
            formViewContainer.backgroundColor = .white
            formViewContainer.addShadow(cornerRadius: 20)
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentContainer: UIStackView!
    
    @IBOutlet weak var stackFormContentContainer: UIStackView!
    @IBOutlet weak var formContentContainer: UIStackView!
    private lazy var segmentedControl: CustomSegmentedView = {
        CustomSegmentedView()
    }()
    
    private lazy var footerBanner: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = ImageAsset.Image.illustrationFooter.image
        return image
    }()
    
    private lazy var sidebarController: SidebarViewController = {
        let sidebarController = SidebarViewController()
        sidebarController.isSetting = true
        return sidebarController
    }()
    
    private lazy var buttonSave: CustomButton = {
        let view = CustomButton()
        view.setTitle(title: "Simpan Profile")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadContent()
        setupView()
    }
    
    func reloadContent() {
        contentContainer.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        
        formContentContainer.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        contentContainer.addArrangedSubview(stackFormContentContainer)
        
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(stackFormContentContainer)
        stackFormContentContainer.fitToSuperView(inset: .init(top: 40.0, left: .zero, bottom: .zero, right: .zero))
        contentContainer.addArrangedSubview(view)
        
        addSegmented()
        addInputs()
        addFooter()
    }
    
    func addInputs() {
        let settingsInputs : [SettingsInput] = [SettingsInput(name: "Nama Depan", placeholder: "Nama"),
                                                SettingsInput(name: "Nama Belakang", placeholder: "Nama Belakang"),
                                                SettingsInput(name: "Email", placeholder: "Masukkan email anda"),
                                                SettingsInput(name: "No Telpon", placeholder: "Masukkan no telpon anda"),
                                                SettingsInput(name: "No. KTP", placeholder: "Masukkan no KTP anda")]
       
        for (index, item) in settingsInputs.enumerated() {
            let text = CustomTextField()
            text.title = item.name ?? .emptyString
            text.placeholder = item.placeholder
            text.translatesAutoresizingMaskIntoConstraints = false
            let view = UIView()
            view.backgroundColor = .clear
            view.addSubview(text)
            view.clipsToBounds = false
            if index == .zero {
                text.fitToSuperView(inset: .init(top: 44.0, left: .zero, bottom: -30.0, right: .zero))
            } else {
                text.fitToSuperView(inset: .init(top: .zero, left: .zero, bottom: -30.0, right: .zero))
            }
            
            formContentContainer.addArrangedSubview(view)
        }
        
        addButton()
    }
    
    func addButton() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(buttonSave)
        view.clipsToBounds = false
        buttonSave.fitToSuperView(inset: .init(top: 34.0, left: .zero, bottom: -30.0, right: .zero))
        formContentContainer.addArrangedSubview(view)
        
        buttonSave.didClickButton = { [weak self] in
            self?.showAlertSave()
        }
    }
    
    
    func addSegmented() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(segmentedControl)
        segmentedControl.fitToSuperView(inset: .init(top: 40.0, left: 20.0, bottom: 40.0, right: -20.0))
        segmentedControl.setupItem(left: "Profile Saya", right: "Pengaturan")
        contentContainer.insertArrangedSubview(view, at: .zero)
        segmentedControl.backgroundColor = .clear
    }
    
    func addFooter() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(footerBanner)
        footerBanner.fitToSuperView(inset: .init(top: 77.0, left: .zero, bottom: .zero, right: .zero))
        contentContainer.insertArrangedSubview(view, at: contentContainer.subviews.endIndex)
    }
    func setupView() {
        view.backgroundColor = .white
        KeyboardAvoiding.avoidingView = scrollView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func notifBtnTapped(_ sender: Any) {
        showAlertError(message: "Coming Soon")
    }
    
    @IBAction func marketBtnTapped(_ sender: Any) {
        showAlertError(message: "Coming Soon")
    }
    
    @IBAction func sideBarBtnTapped(_ sender: Any) {
        sidebarController.show()
    }
    
    
    func showAlertError(message: String?) {
        guard let topView = UIApplication.topViewController() else { return }
        let alert = UIAlertController(title: message ?? "Internal Server Error", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        topView.present(alert,animated: true, completion: nil )
    }
    
    func showAlertSave() {
        guard let topView = UIApplication.topViewController() else { return }
        let alert = UIAlertController(title: "Profile Saved", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        topView.present(alert,animated: true, completion: nil )
    }
}

struct SettingsInput {
    let name: String?
    let placeholder: String?
}
