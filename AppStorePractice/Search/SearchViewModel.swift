//
//  SearchViewMode.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import Foundation
import RxSwift
import RxCocoa
class SearchViewModel {
    struct Input {
        let searchText: ControlProperty<String> // 검색어
        let searchButtonTap: ControlEvent<Void>// 서치 검색 버튼 클릭
    }
    
    struct Output {
        let iTunes: PublishSubject<[Result]> // 네트워크 통신을 할 것이기 때문에 subject
    }
    
    let disposeBag = DisposeBag()
    func transform(input: Input) -> Output {
        let iTunesList = PublishSubject<[Result]>()
        
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .map { String($0) }
            .flatMap { iTunesNetwork.fetchiTunesData(term: $0) }
            .subscribe(with: self, onNext: { owner, value in
                let data = value.results
                                iTunesList.onNext(data)
                                print("Transform Next")
                            }, onError: { _, _ in
                                print("Transform Error")
                            }, onCompleted: { _ in
                                print("Transform Completed")
                
                            }, onDisposed: { _ in
                                print("Transform Disposed")
            })
            .disposed(by: disposeBag)

        return Output(iTunes: iTunesList)
    }
}
