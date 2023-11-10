//
//  FormViewModel.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import Foundation
import RxSwift
import RxRelay

protocol FormViewModel {
    var isLoading: BehaviorSubject<Bool> { get }
    var cells: [CellInterface] { get set }
    var updateTableView: PublishSubject<[CellInterface]> { get set }
    // MARK: Event
    func onViewDidLoad()
    func onSubmitButton()
}
