//
//  Article.swift
//  API
//
//  Created by Valentyn Mialin on 19.09.2020.
//

import Foundation

// MARK: - ArticleResult
public struct ArticleResult: Codable {
    public var results: [Article]
}

// MARK: - Article
public struct Article: Codable {
    public var url: String
    public var id: Int
    public var title: String
}
