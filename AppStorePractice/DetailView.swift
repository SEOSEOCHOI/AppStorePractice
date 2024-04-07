//
//  Detail.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import UIKit
import SnapKit

class DetailView: BaseView {
    let label = UILabel()
    
    override func configureHierarchy() {
        addSubview(label)
    }
    override func configureLayout() {
        label.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaInsets)
        }
    }
    override func configureView() {
        super.configureView()
    }

}
