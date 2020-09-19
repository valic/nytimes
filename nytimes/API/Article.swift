//
//  Article.swift
//  API
//
//  Created by Valentyn Mialin on 19.09.2020.
//

import Foundation
import CoreData

// MARK: - ArticleResult
struct ArticleResult: Codable {
     var results: [Article]
}

// MARK: - Article
class Article: NSManagedObject, Codable {
    enum CodingKeys: String, CodingKey {
        case url
        case id
        case title = "title"
    }
    
    @NSManaged var url: String?
    @NSManaged var id: Int
    @NSManaged var title: String?
    
    // MARK: - Decodable
    required convenience  init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Article", in: managedObjectContext) else {
            fatalError("Failed to decode Article")
        }
        self.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.url = try container.decodeIfPresent(String.self, forKey: .url)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
    }
    
    // MARK: - Encodable
     func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(url, forKey: .url)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
    }
}
