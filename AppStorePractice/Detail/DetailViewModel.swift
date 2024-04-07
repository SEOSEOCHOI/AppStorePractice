//
//  DetailViewModel.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import Foundation
import RxSwift
import RxCocoa
class DetailViewModel {
    struct Input {
        let result: Result
    }
    struct Output {
        let appData: Driver<Result>
        let photoList: Driver<[String]>
    }
    let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        print("startTransform")
        print("=============================")
        print(input.result)
        print("=============================")
        print(input.result.screenshotUrls)
        print("=============================")


        let appData = PublishRelay<Result>()
        let photoList = PublishRelay<[String]>()

        appData.accept(input.result)
        photoList.accept(input.result.screenshotUrls)
        
        let appDataResult = appData.asDriver(onErrorJustReturn: input.result)
        let photoListResult = photoList.asDriver(onErrorJustReturn: [])
        print("end Transform")

        
        return Output(appData: appDataResult,
                      photoList: photoListResult)
    }
}
