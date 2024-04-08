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
        let itemSelectd: ControlEvent<IndexPath>
        let modelSelectd: ControlEvent<Result>
    }
    
    struct Output {
        let iTunes: PublishSubject<[Result]>
        let modelSelected: ControlEvent<Result>
        let iTunseData: PublishRelay<Result>
    }
    
    let disposeBag = DisposeBag()
    func transform(input: Input) -> Output {
        let iTunesList = PublishSubject<[Result]>()
        let appData = PublishRelay<Result>()
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .map { String($0) }
            .flatMap {
                iTunesNetwork.fetchiTunesDataWithSingle(term: $0)
                    .catch { error in
                        return Single<iTunes>.never()
                    }}
            .subscribe(with: self, onNext: { owner, value in
                let data = value.results
                iTunesList.onNext(data)
                
            })
            .disposed(by: disposeBag)
        
        Observable.zip(input.itemSelectd, input.modelSelectd)
            .bind(with: self) { owner, value in
                appData.accept(value.1)
            }
            .disposed(by: disposeBag)
        
        return Output(iTunes: iTunesList,
                      modelSelected: input.modelSelectd,
                      iTunseData: appData)
    }
}
