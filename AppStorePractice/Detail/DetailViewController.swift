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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        navigationController?.navigationBar.prefersLargeTitles = false
        bind()

    }
    func bind() {

        appData
            .throttle(.never, scheduler: MainScheduler.instance)
            .bind(with: self, onNext: { owner, value in
            // titleView
            let image = URL(string: value.artworkUrl60)
            owner.mainView.appTitleView.appNameLabel.text = value.trackCensoredName
            owner.mainView.appTitleView.appIconImageView.kf.setImage(with: image)
            owner.mainView.appTitleView.artistNameLabel.text = value.artistName
                
            //updateView
            owner.mainView.versionLabel.text = value.version
            owner.mainView.versionTextView.text = value.releaseNotes
            
            // explainTextView
            owner.mainView.explainTextView.text = value.description
            
            owner.photoList.accept(value.screenshotUrls)
        })
        .disposed(by: disposeBag)
        
        
        photoList.bind(to: mainView.collectionView.rx.items(cellIdentifier: DetailCollectionViewCell.identifier, cellType: DetailCollectionViewCell.self)) {indexPath, value, cell in
            let url = URL(string: value)
            cell.postetImageView.kf.setImage(with: url)
        }
        .disposed(by: disposeBag)

        appData.accept(result!)

    }
}
