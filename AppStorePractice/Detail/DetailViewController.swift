//
//  DetailViewController.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class DetailViewController: UIViewController {
    let mainView = DetailView()
    override func loadView() {
        self.view = mainView
    }
    var result: Result?
    var appData = PublishRelay<Result>()
    var photoList = PublishRelay<[String]>()
    let disposeBag = DisposeBag()
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = result?.trackCensoredName
        print("before bind")
        bind()
        print("after bind")

    }
    func bind() {
        print("start bind")

        guard let result = result else { return }
        print("before Input")
        let input = DetailViewModel.Input(result: result)
        let output = viewModel.transform(input: input)

        print("befor Output")

        output.appData
            .debug()
            .drive(with: self, onNext: { owner, value in
                print("====================", value,"====================")

            let image = URL(string: value.artworkUrl60)
            owner.mainView.appTitleView.appNameLabel.text = value.trackCensoredName
            owner.mainView.appTitleView.appIconImageView.kf.setImage(with: image)
            owner.mainView.appTitleView.artistNameLabel.text = value.artistName
                
            //updateView
            owner.mainView.versionLabel.text = value.version
            owner.mainView.versionTextView.text = value.releaseNotes
            
            // explainTextView
            owner.mainView.explainTextView.text = value.description
            })
        .disposed(by: disposeBag)
        
        
        output.photoList
            .debug()
            .drive(mainView.collectionView.rx.items(cellIdentifier: DetailCollectionViewCell.identifier, cellType: DetailCollectionViewCell.self)) {indexPath, value, cell in
                print("====================", value,"====================")

            let url = URL(string: value)
            cell.postetImageView.kf.setImage(with: url)
        }
        .disposed(by: disposeBag)
        
        print("end bind")


    }
}
