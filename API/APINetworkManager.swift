//
//  APINetworkManager.swift
//  API
//
//  Created by Valentyn Mialin on 19.09.2020.
//

import Foundation
import Moya

public struct APINetworkManager {
    
    public init() {}
       #if DEBUG
           let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin(verbose: true)])
       #else
           let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin(verbose: false)])
       #endif
    
    fileprivate var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        //        decoder .dateDecodingStrategy = .iso8601
        return decoder
    }
    
    // MARK: - Requests
    
    public func emailed(completion: @escaping (_ r: ResponseA<Article>) -> Void) {
        provider.request(.emailed(period: 30)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let articles = try self.decoder.decode(ArticleResult.self, from: response.data).results
                    completion(ResponseA.success(articles))
                } catch let error {
                    print(error)
                    completion(ResponseA.failure(error: error))
                }
            case .failure(let error):
                completion(ResponseA.failure(error: error))
                print(error)
            }
        }
    }
    
    public func shared(completion: @escaping (_ r: ResponseA<Article>) -> Void) {
        provider.request(.shared(period: 30)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let articles = try self.decoder.decode(ArticleResult.self, from: response.data).results
                    completion(ResponseA.success(articles))
                } catch let error {
                    print(error)
                    completion(ResponseA.failure(error: error))
                }
            case .failure(let error):
                completion(ResponseA.failure(error: error))
                print(error)
            }
        }
    }
    
    public func viewed(completion: @escaping (_ r: ResponseA<Article>) -> Void) {
        provider.request(.viewed(period: 30)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let articles = try self.decoder.decode(ArticleResult.self, from: response.data).results
                    completion(ResponseA.success(articles))
                } catch let error {
                    print(error)
                    completion(ResponseA.failure(error: error))
                }
            case .failure(let error):
                completion(ResponseA.failure(error: error))
                print(error)
            }
        }
    }
}
