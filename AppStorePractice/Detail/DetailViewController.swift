//
//  DetailViewController.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    let mainView = DetailView()
    override func loadView() {
        self.view = mainView
    }
    var result: Result?
    var appData = PublishRelay<Result>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        print(result)
        appData.bind(with: self, onNext: { owner, value in
            print(value)
            owner.mainView.label.text = value.trackCensoredName
        })        
        .disposed(by: disposeBag)
        appData.accept(result!)

        
        appData.subscribe(onNext: { value in
            print("Received value: \(value)")
        }).disposed(by: disposeBag)

    }
    



}
