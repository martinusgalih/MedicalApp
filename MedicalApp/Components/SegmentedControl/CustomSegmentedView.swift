//
//  CustomSegmentedView.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 10/11/23.
//

import UIKit

class CustomSegmentedView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var segmentedControl: CustomSegmentedControl!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadNib()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadNib() {
        self.backgroundColor = .white
        self.clipsToBounds = false
        Bundle.main.loadNibNamed("CustomSegmentedView", owner: self, options: nil)
        
        addSubview(contentView)
        contentView.clipsToBounds = false
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        contentView.backgroundColor = .white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        contentView.addShadow(cornerRadius: segmentedControl.bounds.height / 2)
        segmentedControl.backgroundColor = .white
    }
    
    func setupItem(left: String, right: String) {
        segmentedControl.setTitle(left, forSegmentAt: .zero)
        segmentedControl.setTitle(right, forSegmentAt: 1)
    }
    
}

final class CustomSegmentedControl: UISegmentedControl{
    private let segmentInset: CGFloat = 5  //your inset amount
    private let segmentImage: UIImage? = UIImage(color: .Secondary)//your color
    
    override func layoutSubviews(){
        super.layoutSubviews()
        backgroundColor = .white
        tintColor = .white
        layer.masksToBounds = true
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Title]
        setTitleTextAttributes(titleTextAttributes, for: .selected)
        setTitleTextAttributes(titleTextAttributes, for: .normal)
        //background
        layer.cornerRadius = bounds.height / 2
        layer.backgroundColor = UIColor.white.cgColor
        //foreground
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            foregroundImageView.image = segmentImage
            foregroundImageView.layer.removeAnimation(forKey: "SelectionBounds")
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.layer.cornerRadius = foregroundImageView.bounds.height / 2
        }
    }
}

extension UIImage{
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
