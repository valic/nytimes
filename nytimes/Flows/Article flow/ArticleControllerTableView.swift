//
//  ArticleControllerTableView.swift
//  nytimes
//
//  Created by Valentyn Mialin on 19.09.2020.
//  
//
import UIKit
import API

extension ArticleController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = viewModel.articles[indexPath.row]
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = article.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
