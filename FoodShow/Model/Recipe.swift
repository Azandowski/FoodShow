//
//  Food.swift
//  FoodShow
//
//  Created by AzaDev on 12/26/20.
//  Copyright © 2020 TeamOfFour. All rights reserved.
//

import Foundation
import SDWebImageSVGCoder

struct Recipes: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable {
    let vegetarian, vegan, glutenFree, dairyFree: Bool?
    let veryHealthy, cheap, veryPopular, sustainable: Bool?
    let weightWatcherSmartPoints: Int?
    let gaps: String?
    let lowFodmap: Bool?
    let aggregateLikes, spoonacularScore, healthScore: Int?
    let creditsText, license, sourceName: String?
    let pricePerServing: Double?
    let extendedIngredients: [ExtendedIngredient]?
    let id: Int
    let title: String
    let readyInMinutes, servings: Int
    let sourceURL: String?
    let image: String?
    let imageType, summary: String?
    let cuisines, dishTypes, diets, occasions: [String]?
    let instructions: String?
    let analyzedInstructions: [AnalyzedInstruction]?
    let originalID: JSONNull?
    let spoonacularSourceURL: String?
    let preparationMinutes, cookingMinutes: Int?
    var isFav: Bool  =  false

    func fetchUmage () -> UIImage? {
        let image = UIImageView()
        image.sd_setImage(with: URL(string: self.image!))
        return image.image
    }
    
    enum CodingKeys: String, CodingKey {
        case vegetarian, vegan, glutenFree, dairyFree, veryHealthy, cheap, veryPopular, sustainable, weightWatcherSmartPoints, gaps, lowFodmap, aggregateLikes, spoonacularScore, healthScore, creditsText, license, sourceName, pricePerServing, extendedIngredients, id, title, readyInMinutes, servings
        case sourceURL = "sourceUrl"
        case image, imageType, summary, cuisines, dishTypes, diets, occasions, instructions, analyzedInstructions
        case originalID = "originalId"
        case spoonacularSourceURL = "spoonacularSourceUrl"
        case preparationMinutes, cookingMinutes
    }
}

struct AnalyzedInstruction: Codable {
    let name: String
    let steps: [Step]
}

struct Step: Codable {
    let number: Int
    let step: String
    let ingredients, equipment: [Ent]
    let length: Length?
}

struct Ent: Codable {
    let id: Int
    let name, localizedName, image: String
}

struct Length: Codable {
    let number: Int
    let unit: String
}

struct ExtendedIngredient: Codable {
    let id: Int?
    let aisle, image: String?
    let consistency: Consistency?
    let name, original, originalString, originalName: String
    let amount: Double
    let unit: String
    let meta, metaInformation: [String]
    let measures: Measures
}

enum Consistency: String, Codable {
    case liquid = "liquid"
    case solid = "solid"
}

struct Measures: Codable {
    let us, metric: Metric
}

struct Metric: Codable {
    let amount: Double
    let unitShort, unitLong: String
}


class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
