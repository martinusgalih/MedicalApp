//
//  ProductCollectionView.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import UIKit

class ProductCollectionView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var headerCollectionView: UICollectionView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    let categoriesItem: [String] = ["All Product", "Layanan Kesehatan", "Alat Kesehatan"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadNib() {
        self.backgroundColor = .clear
        self.clipsToBounds = false
        Bundle.main.loadNibNamed("ProductCollectionView", owner: self, options: nil)
        
        addSubview(contentView)
        contentView.clipsToBounds = false
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentView.backgroundColor = .clear
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        headerCollectionView.register(UINib(nibName: HeaderCell.className(), bundle: nil), forCellWithReuseIdentifier: HeaderCell.className())
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        headerCollectionView.showsHorizontalScrollIndicator = false
        
        contentCollectionView.register(UINib(nibName: ContentProductCell.className(), bundle: nil), forCellWithReuseIdentifier: ContentProductCell.className())
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        
        headerCollectionView.backgroundColor = .white
        contentCollectionView.backgroundColor = .white
    }
}

extension ProductCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == headerCollectionView {
            return categoriesItem.count
        } else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == headerCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeaderCell.className(), for: indexPath) as? HeaderCell else { return UICollectionViewCell() }
            cell.tagLabel.text = categoriesItem[indexPath.row]
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentProductCell.className(), for: indexPath) as? ContentProductCell else { return UICollectionViewCell() }
            cell.contentView.addShadow(cornerRadius: 16)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == headerCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as? HeaderCell
            cell?.setDeselectCell()
        } else {

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == headerCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as? HeaderCell
            cell?.setSelectedCell()
        } else {


        }
    }
}
