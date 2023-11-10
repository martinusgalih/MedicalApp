//
//  SidebarViewController.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import UIKit

class SidebarViewController: UIViewController {

    @IBOutlet weak var rightContainer: UIView!
    
    var isSetting: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rightContainer.layoutIfNeeded()
    }
    
    func show() {
        sheetShow(width: UIScreen.main.bounds.size.width, direction: .right, didAutoClose: {
        })
    }

    @IBAction func logoutBtnTapped(_ sender: Any) {
        showAlertError()
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        sheetClose()
    }
    
    @IBAction func settingBtnTapped(_ sender: Any) {
        sheetClose { [weak self] in
            guard self?.isSetting == false else { return }
            guard let topView = UIApplication.topViewController()  else { return }
            topView.navigationController?.pushViewController(SettingsViewController(), animated: true)
        }
    }
    
    func showAlertError() {
        guard let topView = UIApplication.topViewController() else { return }
        let alert = UIAlertController(title: "Are you sure want to logout?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [weak self] _ in
            guard let self = self,
                let topView = UIApplication.topViewController()  else { return }
            UserDefault.removeUserToken()
            self.sheetClose {
                topView.navigationController?.pushViewController(FormViewController(viewModel: LoginViewModel()), animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "No, cancel", style: .default, handler: nil))
        topView.present(alert,animated: true, completion: nil )
    }
}
