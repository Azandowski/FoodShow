//
//  Endpoint.swift
//  FoodShow
//
//  Created by AzaDev on 12/26/20.
//  Copyright © 2020 TeamOfFour. All rights reserved.
//

import Foundation

enum Router {
    
    case getRandom
    
    var accessToken: String {
        return "7fc7a140de7a412aa0a77cf1e7a6d502"
    }
    
    
    var scheme: String {
        switch self {
        case .getRandom:
            return "https"
        }
    }
    
    var host: String {
        let base = "api.spoonacular.com"
        switch self {
        case .getRandom:
            return base
        }
    }
    
    var path: String {
        switch self {
        case .getRandom:
            return "/recipes/random"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getRandom:
            return [URLQueryItem(name: "limitLicense", value: "false"),
                    URLQueryItem(name: "number", value: "5"),
                    URLQueryItem(name: "apiKey", value: accessToken)]
        }
    }
    
    var method: String {
        switch self {
        case .getRandom:
            return "GET"
        }
    }
    
}
