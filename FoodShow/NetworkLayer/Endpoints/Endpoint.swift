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
    case getSimilar
    
    var accessToken: String {
        return "6c2f2b1eded0428582f6add38a448913"
    }
    
    
    var scheme: String {
        switch self {
        case .getRandom:
            return "https"
        default:
            return "https"
        }
    }
    
    var host: String {
        let base = "api.spoonacular.com"
        switch self {
        case .getRandom:
            return base
        default:
            return base
        }
    }
    
    func getPath(id:Int?)->String{
       switch self {
        case .getRandom:
            return "/recipes/random"
        case .getSimilar:
            return "/recipes/\(id ?? 638409)/similar"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getRandom:
            return [URLQueryItem(name: "limitLicense", value: "false"),
                    URLQueryItem(name: "number", value: "5"),
                    URLQueryItem(name: "apiKey", value: accessToken)]
        case .getSimilar:
            return [URLQueryItem(name: "limitLicense", value: "false"),
                    URLQueryItem(name: "number", value: "5"),
                    URLQueryItem(name: "apiKey", value: accessToken)]
        }
    }
    
    var method: String {
        switch self {
        case .getRandom:
            return "GET"
        default:
            return "GET"
        }
    }
    
}
