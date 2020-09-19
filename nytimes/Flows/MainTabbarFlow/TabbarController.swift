//
//  TabbarController.swift
//  nytimes
//
//  Created by Valentyn Mialin on 19.09.2020.
//

import Foundation
import UIKit

enum MainTabBarType: Int, CaseIterable {
    case emailed, shared, viewed, favorites
    
    var title: String {
        switch self {
        case .emailed:
            return NSLocalizedString("Emailed", comment: "").lowercased()
        case .shared:
            return NSLocalizedString("Shared", comment: "").lowercased()
        case .viewed:
            return NSLocalizedString("Viewed", comment: "").lowercased()
        case .favorites:
            return NSLocalizedString("Favorites", comment: "").lowercased()
        }
    }
}

final class TabbarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tabBar.isTranslucent = false
        
        var viewControllers = [UIViewController]()
        let tabBarTypeArray: [MainTabBarType] = MainTabBarType.allCases
        
        tabBarTypeArray.forEach { (tabBarType) in
            let navigationController = UINavigationController()
            navigationController.tabBarItem = UITabBarItem(title: tabBarType.title, image: nil, selectedImage: nil)
            navigationController.tabBarItem.tag = tabBarType.rawValue
            
            switch tabBarType {
            case .favorites:
                let vc = UIViewController()
                vc.title = tabBarType.title
                vc.view.backgroundColor = .white
                navigationController.addChild(vc)
                viewControllers.append(navigationController)
            default:
                let vc = ArticleController(viewModel: ArticleViewModel(mainTabBarType: tabBarType))
                navigationController.addChild(vc)
                viewControllers.append(navigationController)
            }
        }
        
        self.viewControllers = viewControllers
        
        delegate = self
        self.selectedIndex = 0
    }
}
