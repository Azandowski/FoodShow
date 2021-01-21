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
    case getSearch
    case getRecipesById
    
    
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
       case .getSearch:
        return "/recipes/complexSearch"
       case .getRecipesById:
        return "/recipes/informationBulk"
       }
    }
    
    func parameters(params: [URLQueryItem]) -> [URLQueryItem] {
        switch self {
        case .getRandom:
            return [URLQueryItem(name: "limitLicense", value: "false"),
                    URLQueryItem(name: "number", value: "8"),
                    URLQueryItem(name: "apiKey", value: accessToken)]
        case .getSimilar:
            return [URLQueryItem(name: "limitLicense", value: "false"),
                    URLQueryItem(name: "number", value: "6"),
                    URLQueryItem(name: "apiKey", value: accessToken)]
        case .getSearch:
            return [URLQueryItem(name: "limitLicense", value: "false"),
                    URLQueryItem(name: "number", value: "10"),
                    URLQueryItem(name: "apiKey", value: accessToken)] + params
        case .getRecipesById:
                return [URLQueryItem(name: "limitLicense", value: "false"),
                        URLQueryItem(name: "number", value: "10"),
                        URLQueryItem(name: "apiKey", value: accessToken)] + params
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
