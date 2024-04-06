//
//  SearchViewController.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {
    let mainView = SearchView()
    override func loadView() {
        self.view = mainView
    }
    let viewModel = SearchViewModel()
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        configureNavigation()
    }
    func configureNavigation() {
        // title
        navigationItem.title = "검색"
        navigationController?.navigationBar.prefersLargeTitles = true

        // searchController
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"

        navigationItem.hidesSearchBarWhenScrolling = false
    }

    
}
