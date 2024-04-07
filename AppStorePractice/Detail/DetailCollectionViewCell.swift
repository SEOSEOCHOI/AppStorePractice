//
//  DetailCollectionViewCell.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import UIKit

final class DetailCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchTableViewCell"
    let postetImageView = PosterImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        postetImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    private func configureHierarchy() {
        contentView.addSubview(postetImageView)
    }
    
    private func configureView() {
    }
}
