//
//  SpaceCell.swift
//  MedicalApp
//
//  Created by Martinus Galih Widananto on 09/11/23.
//

import UIKit

public final class SpaceCellViewModel: CellInterface {
    var height: CGFloat
    
    init(height: CGFloat) {
        self.height = height
    }
}

public class SpaceCell: UITableViewCell {
    private var spacer: SpaceView!
    
    var viewModel: SpaceCellViewModel!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        spacer.removeFromSuperview()
        viewModel = nil
    }
}


extension SpaceCell {
    func bind(_ viewModel: SpaceCellViewModel) {
        self.viewModel = viewModel
        attachViews()
    }
}

private extension SpaceCell {
    func attachViews() {
        self.spacer = .init(viewModel.height)
        contentView.backgroundColor = .white
        contentView.addSubview(self.spacer)
        NSLayoutConstraint.activate([
            spacer.topAnchor.constraint(equalTo: contentView.topAnchor),
            spacer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            spacer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            spacer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}
