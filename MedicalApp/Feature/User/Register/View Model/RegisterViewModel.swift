//
//  RegisterViewModel.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import Foundation
import RxSwift
import RxCocoa

class RegisterViewModel: FormViewModel {
    var isLoading: RxSwift.BehaviorSubject<Bool> = .init(value: false)
    var isSuccess: RxSwift.BehaviorSubject<Bool> = .init(value: false)
    var cells: [CellInterface] = []
    var updateTableView: PublishSubject<[CellInterface]> = .init()
    
    func onViewDidLoad() {
        cells.removeAll()
        cells.append(SpaceCellViewModel(height: 66.0))
        cells.append(WelcomeHeaderCellViewModel(title: "Hai, Selamat Datang", subtitle: "Silahkan login untuk melanjutkan"))
        cells.append(InputFieldCellViewModel(type: .default, title: "Nama", placeHolder: "Masukkan nama anda"))
        cells.append(SpaceCellViewModel(height: 40.0))
        cells.append(InputFieldCellViewModel(type: .default, title: "No. KTP", placeHolder: "Masukkan No. KTP anda"))
        cells.append(SpaceCellViewModel(height: 40.0))
        cells.append(InputFieldCellViewModel(type: .email, title: "Email", placeHolder: "Masukkan email anda"))
        cells.append(SpaceCellViewModel(height: 40.0))
        cells.append(InputFieldCellViewModel(type: .phoneNumber, title: "No. Telpon", placeHolder: "Masukkan nomor telepon"))
        cells.append(SpaceCellViewModel(height: 40.0))
        cells.append(InputFieldCellViewModel(type: .password, title: "Password", placeHolder: "Masukkan password anda"))
        cells.append(SpaceCellViewModel(height: 40.0))
        cells.append(InputFieldCellViewModel(type: .password, title: "Konfirmasi Password", placeHolder: "Masukkan password anda"))
        cells.append(SpaceCellViewModel(height: 40.0))
        cells.append(ButtonCellViewModel(title: "Login"))
        cells.append(SpaceCellViewModel(height: 30.0))
        cells.append(loginLabel)
        cells.append(SpaceCellViewModel(height: 40.0))
        cells.append(FooterCellViewModel())
        cells.append(SpaceCellViewModel(height: 40.0))
        updateTableView.onNext(cells)
    }
    
    func onSubmitButton() {
        
    }
    
    lazy var loginLabel: RegisterCellViewModel = {
        let viewModel = RegisterCellViewModel(leftLabel: "Sudah punya akun ?", rightLabel: "Login sekarang")
        viewModel.didClickButton = { [weak self] in
            guard let self = self else { return }
            guard let topView = UIApplication.topViewController() else { return }
            topView.navigationController?.popViewController(animated: true)
        }
        return viewModel
    }()
}
