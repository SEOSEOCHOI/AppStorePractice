//
//  SearchView.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import UIKit
import SnapKit

class SearchView: BaseView {
    let tableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .clear
        view.rowHeight = 100
        return view
    }()
    override func configureHierarchy() {
        addSubview(tableView)
    }
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    override func configureView() {
        super.configureView()
    }

}
