//
//  CodingUserInfoKey+Util.swift
//  nytimes
//
//  Created by Valentyn Mialin on 19.09.2020.
//

import Foundation

public extension CodingUserInfoKey {
    // Helper property to retrieve the Core Data managed object context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
