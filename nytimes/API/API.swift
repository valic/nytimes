//
//  API.swift
//  API
//
//  Created by Valentyn Mialin on 19.09.2020.
//

import Foundation
import Moya

enum API {
    /// Returns an array of the most emailed articles on NYTimes.com for specified period of time (1 day, 7 days, or 30 days).
    /// - period: The following values are allowed: 1, 7, 30
    case emailed(period: Int)
    case shared(period: Int)
    case viewed(period: Int)
}

extension API: Moya.TargetType {
    var environmentBaseURL: String {
        return "https://api.nytimes.com/svc/mostpopular/v2"
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    var path: String {
        switch self {
        case .emailed(let period):
            return "/emailed/\(period).json"
        case .shared(let period):
            return "/shared/\(period).json"
        case .viewed(let period):
            return "/viewed/\(period).json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestParameters(parameters: ["api-key": "PbcaqI2DAddjGZuEuxJdaZTUD4JtGVBF"], encoding: URLEncoding.queryString)
    }
    
    var headers: [String: String]? {
        return nil
    }
    

}
