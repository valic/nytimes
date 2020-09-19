//
//  ArticleViewModel.swift
//  nytimes
//
//  Created by Valentyn Mialin on 19.09.2020.
//  
//

import Foundation
import API

class ArticleViewModel {
    var onUpdateArticlesHandler: (() -> Void)?
    var onErrorHandler: ((Error) -> Void)?
    
    let mainTabBarType: MainTabBarType
    var articles = [Article]() {
        didSet {
            onUpdateArticlesHandler?()
        }
    }
    
    init(mainTabBarType: MainTabBarType) {
        self.mainTabBarType = mainTabBarType
    }
    
    func load() {
        let networkManager = APINetworkManager()
        switch mainTabBarType {

        case .emailed:
            networkManager.emailed { (response) in
                switch response {
                case .success(let articles):
                    self.articles = articles
                case .failure(let error):
                    self.onErrorHandler?(error)
                }
            }
        case .shared:
            networkManager.shared { (response) in
                switch response {
                case .success(let articles):
                    self.articles = articles
                case .failure(let error):
                    self.onErrorHandler?(error)
                }
            }
        case .viewed:
            networkManager.viewed { (response) in
                switch response {
                case .success(let articles):
                    self.articles = articles
                case .failure(let error):
                    self.onErrorHandler?(error)
                }
            }
        default:
            break
        }
    }
}
