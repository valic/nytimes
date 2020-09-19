//
//  ArticleUserInterface.swift
//  nytimes
//
//  Created by Valentyn Mialin on 19.09.2020.
//  
//

import UIKit
import Foundation

extension ArticleController {
    
    func setupUI() {
        title = self.viewModel.mainTabBarType.title
        self.view.backgroundColor = .systemBackground
        
        setupTableView()
    }
    
    fileprivate func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}
