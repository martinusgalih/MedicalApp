//
//  LoginViewModel.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel: FormViewModel {
    var isLoading: RxSwift.BehaviorSubject<Bool> = .init(value: false)
    var cells: [CellInterface] = []
    var updateTableView: PublishSubject<[CellInterface]> = .init()
    let login = UserApiServices()
    
    func onViewDidLoad() {
        cells.removeAll()
        cells.append(SpaceCellViewModel(height: 66.0))
        cells.append(WelcomeHeaderCellViewModel(title: "Hai, Selamat Datang", subtitle: "Silahkan login untuk melanjutkan"))
        cells.append(email)
        cells.append(SpaceCellViewModel(height: 40.0))
        cells.append(password)
        cells.append(SpaceCellViewModel(height: 40.0))
        cells.append(buttonContinue)
        cells.append(SpaceCellViewModel(height: 30.0))
        cells.append(registerLabel)
        cells.append(SpaceCellViewModel(height: 40.0))
        cells.append(FooterCellViewModel())
        cells.append(SpaceCellViewModel(height: 40.0))
        updateTableView.onNext(cells)
    }
    
    func onSubmitButton() {
        onLogin()
    }
    
    func onLogin() {
        isLoading.onNext(true)
        login.login(email: email.value, password: password.value) { [weak self] isSuccess, response in
            guard let self = self else { return }
            self.isLoading.onNext(false)
            if isSuccess {
                UserDefault.saveUserToken(token: response)
                guard let topView = UIApplication.topViewController() else { return }
                topView.navigationController?.pushViewController(HomepageViewController(), animated: true)
            } else {
                self.showAlertError(message: response)
            }
        }
    }
    
    lazy var email: InputFieldCellViewModel = {
        let viewModel = InputFieldCellViewModel(type: .email, title: "Email", placeHolder: "Masukkan email anda")
        return viewModel
    }()
    
    lazy var password: InputFieldCellViewModel = {
        let viewModel = InputFieldCellViewModel(type: .password, title: "Password", placeHolder: "Masukkan password anda")
        return viewModel
    }()
    
    lazy var registerLabel: RegisterCellViewModel = {
        let viewModel = RegisterCellViewModel(leftLabel: "Belum punya akun ?", rightLabel: "Daftar sekarang")
        viewModel.didClickButton = { [weak self] in
            guard let self = self else { return }
            guard let topView = UIApplication.topViewController() else { return }
            let vc = FormViewController(viewModel: RegisterViewModel())
            topView.navigationController?.pushViewController(vc, animated: true)
        }
        return viewModel
    }()
    
    lazy var buttonContinue: ButtonCellViewModel = {
        let viewModel = ButtonCellViewModel(title: "Login")
        viewModel.didClickButton = { [weak self] in
            guard let self = self else { return }
            self.onSubmitButton()
        }
        return viewModel
    }()
    
    func showAlertError(message: String?) {
        guard let topView = UIApplication.topViewController() else { return }
        let alert = UIAlertController(title: message ?? "Internal Server Error", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        topView.present(alert,animated: true, completion: nil )
    }
}
