//
//  ArticleController.swift
//  nytimes
//
//  Created by Valentyn Mialin on 19.09.2020.
//  
//

import UIKit
import Foundation

final class ArticleController: UIViewController, ArticleView {
    var viewModel: ArticleViewModel
    
    // Property
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    // MARK: - Init
    
    init(viewModel: ArticleViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.onUpdateArticlesHandler = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewModel.onErrorHandler = { [weak self] error in
            guard let self = self else { return }
            let titleAction: String = NSLocalizedString("Error", comment: "")
            let message = error.localizedDescription
            
            let alertController = UIAlertController(title: titleAction, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default, handler: nil)
            alertController.addAction(action)
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        viewModel.load()
    }
}
