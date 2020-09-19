//
//  ArticleViewModel.swift
//  nytimes
//
//  Created by Valentyn Mialin on 19.09.2020.
//  
//

import Foundation
import CoreData
import UIKit

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
        case .favorites:
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Article")
            do {
                let objecs = try managedContext.fetch(fetchRequest)
                self.articles = objecs.map({$0 as! Article})
            } catch let error as NSError {
                self.onErrorHandler?(error)
            }
        }
    }
}
