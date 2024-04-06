//
//  BaseView.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    func configureHierarchy() { }
    func configureLayout() { }
    func configureView() { backgroundColor = .white }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
