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

    static func fetchiTunesDataWithSingle (term: String) -> Single<iTunes> {
        
        return  Single.create { single in
            guard let url = URL(string: "https://itunes.apple.com/search?term=\(term)&country=KR&media=software&limit=10") else {
                single(.failure(APIError.invalidURL))
                return Disposables.create()
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.setValue("ABC", forHTTPHeaderField: "User-Agent")
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                print("DataTask Succeed")
                
                if let _ = error {
                    single(.failure(APIError.unknownResponse))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    print("Response Error")
                    single(.failure(APIError.statusError))
                    return
                }
                
                
                if let data = data,
                    let appData = try? JSONDecoder().decode(iTunes.self, from: data) {
                    
                    single(.success(appData))

                } else {
                    print("응답은 왔으나 디코딩 실패")
                    single(.failure(APIError.unknownResponse))
                }
            }.resume()
            return Disposables.create()
            
        }.debug()
    }
}

