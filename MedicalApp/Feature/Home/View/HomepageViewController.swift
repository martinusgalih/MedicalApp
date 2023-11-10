//
//  HomepageViewController.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit
import IHKeyboardAvoiding

class HomepageViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentContainer: UIStackView!
    
    private lazy var infoHealthView: InfoHealthView = {
        let view = InfoHealthView()
        return view
    }()
    
    private lazy var specificServiceView: SpecificServiceView = {
        let view = SpecificServiceView()
        return view
    }()
    
    private lazy var trackingServiceView: TrackServiceView = {
        let view = TrackServiceView()
        return view
    }()
    
    private lazy var searchBar: SearchBar = {
        SearchBar()
    }()
    
    private lazy var productCollectionView: ProductCollectionView = {
        ProductCollectionView()
    }()
    
    private lazy var segmentedControl: CustomSegmentedView = {
        CustomSegmentedView()
    }()
    
    private lazy var serviceTitleLabel: UILabel = {
        let label =  UILabel()
        label.textColor = .Title
        label.font = FontFamily.Gilroy.light.font(size: 16.0)
        label.text = "Pilih Tipe Layanan Kesehatan Anda"
        return label
    }()
    
    private lazy var footerBanner: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = ImageAsset.Image.illustrationFooter.image
        return image
    }()
    
    private lazy var sidebarController: SidebarViewController = {
        let sidebarController = SidebarViewController()
        return sidebarController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        reloadContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupView() {
        view.backgroundColor = .white
        KeyboardAvoiding.avoidingView = scrollView
    }
    
    func reloadContent() {
        contentContainer.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
        addInfoHeatlhView()
        addSpecificServiceView()
        addTrackingServiceView()
        addSearchBar()
        addProductView()
        addTitleService()
        addSegmented()
        addHealthStack()
        addFooter()
    }
    
    func addInfoHeatlhView() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(infoHealthView)
        infoHealthView.fitToSuperView(inset: .init(top: 28.0, left: 20.0, bottom: .zero, right: -20.0))
        contentContainer.addArrangedSubview(view)
    }
    
    func addSpecificServiceView() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(specificServiceView)
        specificServiceView.fitToSuperView(inset: .init(top: 19.0, left: 20.0, bottom: .zero, right: -20.0))
        contentContainer.addArrangedSubview(view)
    }
    
    func addTrackingServiceView() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(trackingServiceView)
        trackingServiceView.fitToSuperView(inset: .init(top: 40.0, left: 20.0, bottom: .zero, right: -20.0))
        contentContainer.addArrangedSubview(view)
    }
    
    func addSearchBar() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(searchBar)
        searchBar.fitToSuperView(inset: .init(top: 40.0, left: 20.0, bottom: .zero, right: -20.0))
        contentContainer.addArrangedSubview(view)
    }
    
    func addProductView() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(productCollectionView)
        productCollectionView.fitToSuperView(inset: .init(top: 40.0, left: 20.0, bottom: .zero, right: -20.0))
        contentContainer.addArrangedSubview(view)
    }
    
    func addTitleService() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(serviceTitleLabel)
        serviceTitleLabel.fitToSuperView(inset: .init(top: 40.0, left: 20.0, bottom: .zero, right: -20.0))
        contentContainer.addArrangedSubview(view)
    }
    
    func addSegmented() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(segmentedControl)
        segmentedControl.fitToSuperView(inset: .init(top: 22.0, left: 20.0, bottom: .zero, right: -20.0))
        contentContainer.addArrangedSubview(view)
    }
    
    func addHealthStack() {
        let items: [HealthServiceModel] = [HealthServiceModel(title: "PCR Swab Test (Drive Thru) Hasil 1 Hari Kerja", price: "Rp. 1.400.000", place: "Lenmarc Surabaya", location: "Dukuh Pakis, Surabaya", image: ImageAsset.Image.illustrationProductDummy1.rawValue),
                                           HealthServiceModel(title: "PCR Swab Test (Drive Thru) Hasil 1 Hari Kerja", price: "Rp. 1.400.000", place: "Lenmarc Surabaya", location: "Dukuh Pakis, Surabaya", image: ImageAsset.Image.illustrationProductDummy1.rawValue)]
        
        for item in items {
            let view = UIView()
            view.backgroundColor = .clear
            let healthServiceView = HealthServiceView(model: item)
            view.addSubview(healthServiceView)
            healthServiceView.fitToSuperView(inset: .init(top: 22.0, left: 20.0, bottom: .zero, right: -20.0))
            contentContainer.addArrangedSubview(view)
        }
    }
    
    func addFooter() {
        let view = UIView()
        view.backgroundColor = .clear
        view.addSubview(footerBanner)
        footerBanner.fitToSuperView(inset: .init(top: 40.0, left: .zero, bottom: .zero, right: .zero))
        contentContainer.addArrangedSubview(view)
    }
    
    @IBAction func sidebartBtnTapped(_ sender: Any) {
        sidebarController.show()
    }
    
    @IBAction func marketBtnTapped(_ sender: Any) {
        showAlertError(message: "Coming Soon")
    }
    
    @IBAction func notifBtnTapped(_ sender: Any) {
        showAlertError(message: "Coming Soon")
    }
    
    func showAlertError(message: String?) {
        guard let topView = UIApplication.topViewController() else { return }
        let alert = UIAlertController(title: message ?? "Internal Server Error", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        topView.present(alert,animated: true, completion: nil )
    }
}

