//
//  APINetworkManager.swift
//  API
//
//  Created by Valentyn Mialin on 19.09.2020.
//

import Foundation
import Moya
import CoreData

 struct APINetworkManager {
    
     init() {}
       #if DEBUG
           let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin(verbose: true)])
       #else
           let provider = MoyaProvider<API>(plugins: [NetworkLoggerPlugin(verbose: false)])
       #endif
    
    fileprivate var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
            fatalError("Failed to retrieve managed object context")
        }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return decoder
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedContext
        return decoder
    }
    
    // MARK: - Requests
    
     func emailed(completion: @escaping (_ r: ResponseA<Article>) -> Void) {
        provider.request(.emailed(period: 30)) { (result) in
            switch result {
            case .success(let response):
                do {
                    // Parse JSON data
                    let articles = try decoder.decode(ArticleResult.self, from: response.data).results
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
    
     func shared(completion: @escaping (_ r: ResponseA<Article>) -> Void) {
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
    
     func viewed(completion: @escaping (_ r: ResponseA<Article>) -> Void) {
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
