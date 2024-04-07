//
//  SearchViewController.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

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
        bind()
    }
    func configureNavigation() {
        // title
        navigationItem.title = "검색"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    func bind() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        
        let input = SearchViewModel.Input(searchText: searchController.searchBar.rx.text.orEmpty,
                                          searchButtonTap: searchController.searchBar.rx.searchButtonClicked,
                                          itemSelectd: mainView.tableView.rx.itemSelected,
                                          modelSelectd: mainView.tableView.rx.modelSelected(Result.self))
        
        let output = viewModel.transform(input: input)
        
        output.iTunes.bind(to: mainView.tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { indexPath, item, cell in

            cell.appNameLabel.text = item.trackCensoredName
            let image = URL(string: item.artworkUrl60)
            cell.appIconImageView.kf.setImage(with: image)
        }
        .disposed(by: disposeBag)

        output.modelSelected
            .bind(with: self) { owner, value in
                
                let vc = DetailViewController()
                vc.result = value
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
    }

    
}
