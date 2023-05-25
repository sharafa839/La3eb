//
//  ApiEnvironment.swift
//  La3ebAssesment
//
//  Created by Sharaf on 24/05/2023.
//

import Foundation
enum APIEnvironment {
    case development
    case staging
    case production
    
    func baseURL () -> String {
        return "https://\(subdomain())/\(domain())"
    }
    
    func domain() -> String {
        switch self {
        case .development:
            return "api"
        case .staging:
            return "api"
        case .production:
            return "api"
        }
    }
    
    func subdomain() -> String {
        switch self {
        case .development, .production, .staging:
            return "api.rawg.io"
        }
    }
    
    func route() -> String {
        return "/games"
    }
}
