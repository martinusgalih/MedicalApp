//
//  FormViewController.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit
import RxSwift
import RxCocoa
import TPKeyboardAvoiding

class FormViewController: UIViewController {
    @IBOutlet weak var tableView: TPKeyboardAvoidingTableView! {
        didSet {
            tableView.keyboardDismissMode = .onDrag
        }
    }
    
    private let disposeBag = DisposeBag()
    var editingIndexPath: IndexPath = IndexPath(index: .zero)
    var lastScrollIndexPath: IndexPath = IndexPath(index: .zero)
    
    private let viewModel: FormViewModel
    
    init(viewModel: FormViewModel) {
        self.viewModel = viewModel
        super.init(nibName: Self.className(), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        viewModel.onViewDidLoad()
        bind()
        setupObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setup() {
        view.backgroundColor = .white
        
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        
        registerCells()
    }
    
    func registerCells() {
        let cells = [
            WelcomeHeaderCell.self,
            SpaceCell.self,
            InputFieldCell.self,
            ButtonCell.self,
            RegisterCell.self,
            FooterCell.self
        ]
        
        for cell in cells {
            tableView.register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
        }
    }

    
    func bind() {
        viewModel.updateTableView
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                self?.tableView.reloadData()
            }, onError: { error in
                
            }).disposed(by: self.disposeBag)
        
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                self.view.loading(on: isLoading)
            }, onError: { error in
                
            }).disposed(by: self.disposeBag)
    }
    
    func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension FormViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let interface = viewModel.cells[indexPath.row]
        switch interface {
            case is WelcomeHeaderCellViewModel:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: WelcomeHeaderCell.reuseIdentifier, for: indexPath) as? WelcomeHeaderCell,
                      let cellViewModel = interface as? WelcomeHeaderCellViewModel
                else { return UITableViewCell() }
                cell.bind(cellViewModel)
                return cell
            case is SpaceCellViewModel:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: SpaceCell.reuseIdentifier, for: indexPath) as? SpaceCell,
                      let cellViewModel = interface as? SpaceCellViewModel
                else { return UITableViewCell() }
                cell.bind(cellViewModel)
                return cell
            case is InputFieldCellViewModel:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: InputFieldCell.reuseIdentifier, for: indexPath) as? InputFieldCell,
                      let cellViewModel = interface as? InputFieldCellViewModel
                else { return UITableViewCell() }
                cell.bind(cellViewModel)
                return cell
            case is ButtonCellViewModel:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.reuseIdentifier, for: indexPath) as? ButtonCell,
                      let cellViewModel = interface as? ButtonCellViewModel
                else { return UITableViewCell() }
                cell.bind(cellViewModel)
                return cell
            case is RegisterCellViewModel:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: RegisterCell.reuseIdentifier, for: indexPath) as? RegisterCell,
                      let cellViewModel = interface as? RegisterCellViewModel
                else { return UITableViewCell() }
                cell.bind(cellViewModel)
                return cell
            case is FooterCellViewModel:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FooterCell.reuseIdentifier, for: indexPath) as? FooterCell,
                      let cellViewModel = interface as? FooterCellViewModel
                else { return UITableViewCell() }
                cell.bind(cellViewModel)
                return cell
            default:
                return UITableViewCell()
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              keyboardSize.height > 1,
              lastScrollIndexPath != editingIndexPath
        else { return }
        lastScrollIndexPath = editingIndexPath
        tableView.contentInset = .init(top: 44.0, left: .zero, bottom: keyboardSize.height, right: .zero)
        tableView.scrollToRow(at: editingIndexPath, at: .top, animated: true)
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
        lastScrollIndexPath = IndexPath(index: .zero)
    }
}
