//
//  ArticleControllerTableView.swift
//  nytimes
//
//  Created by Valentyn Mialin on 19.09.2020.
//  
//
import UIKit
import API
import SafariServices

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
        let article = viewModel.articles[indexPath.row]
        guard let url = URL(string: article.url) else { return }
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        safariVC.modalPresentationStyle = .popover
        self.present(safariVC, animated: true, completion: nil)
    }
}

// MARK: - SFSafariViewControllerDelegate
extension ArticleController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
