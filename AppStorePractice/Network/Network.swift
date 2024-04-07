//
//  File.swift
//  AppStorePractice
//
//  Created by 최서경 on 4/7/24.
//

import Foundation
import RxSwift
import RxCocoa

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
}

class iTunesNetwork {

    static func fetchiTunesData(term: String) -> Observable<iTunes> {
        
        return  Observable<iTunes>.create { observer in
            guard let url = URL(string: "https://itunes.apple.com/search?term=\(term)1&country=KR&media=software&entity=software&limit=10") else {
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("ABC", forHTTPHeaderField: "User-Agent")
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                print("DataTask Succeed")
                
                if let _ = error {
                    observer.onError(APIError.unknownResponse)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    print("Response Error")
                    observer.onError(APIError.statusError)
                    return
                }
                print(response.statusCode)
                print(urlRequest.url?.description)
                print(urlRequest.allHTTPHeaderFields)
                
                
                if let data = data,
                    let appData = try? JSONDecoder().decode(iTunes.self, from: data) {
                    
                    observer.onNext(appData)
                    observer.onCompleted()

                } else {
                    print("응답은 왔으나 디코딩 실패")
                    observer.onError(APIError.unknownResponse)
                }
            }.resume()
            return Disposables.create()
            
        }.debug()
    }
}

