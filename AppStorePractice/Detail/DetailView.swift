//
//  Detail.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import UIKit
import SnapKit

final class DetailView: BaseView {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let appTitleView = AppTitleView()
    let updateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "새로운 수정"
        return label
    }()
    let versionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    let versionTextView: UITextView = {
       let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    let collectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: DetailView.collectionViewLayout())
        collectionView.register(DetailCollectionViewCell.self, forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        return collectionView
    }()

    let explainTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
         return textView
    }()
    let lastView = UIView()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(appTitleView)
        contentView.addSubview(updateLabel)
        contentView.addSubview(versionLabel)
        contentView.addSubview(versionTextView)
        contentView.addSubview(collectionView)
        contentView.addSubview(explainTextView)
        contentView.addSubview(lastView)
    }
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
        appTitleView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(100)
        }
        updateLabel.snp.makeConstraints { make in
            make.top.equalTo(appTitleView.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(4)
        }
        versionLabel.snp.makeConstraints { make in
            make.top.equalTo(updateLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().inset(4)
        }
        versionTextView.snp.makeConstraints { make in
            make.top.equalTo(versionLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(4)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(versionTextView.snp.bottom)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(UIScreen.main.bounds.size.width * 0.7 * 2.164)
        }
        explainTextView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(4)
        }
        lastView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(explainTextView.snp.bottom).offset(4)
            make.height.equalTo(35)
            make.bottom.equalTo(contentView).inset(4)
        }
       
    }
    override func configureView() {
        super.configureView()
    }
    static func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 8
        let itemSize = UIScreen.main.bounds.size.width * 0.7
        layout.itemSize = CGSize(width: itemSize, height: itemSize * 2.164)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = itemSpacing // 수평 간격
        return layout
    }

}
