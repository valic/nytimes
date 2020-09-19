//
//  Response.swift
//  API
//
//  Created by Valentyn Mialin on 19.09.2020.
//

import Foundation

public enum ResponseA<T: Codable> {
    case failure(error: Error)
    case success([T])
}

public enum ResponseB<T: Codable> {
    case failure(error: Error)
    case success(T)
}
