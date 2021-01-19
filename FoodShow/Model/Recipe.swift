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
    let vegetarian, vegan, glutenFree: Bool?
    let veryHealthy, cheap: Bool?
    let gaps: String?
    let aggregateLikes, spoonacularScore, healthScore: Int?
    let sourceName: String?
    var pricePerServing: Double?
    let extendedIngredients: [ExtendedIngredient]?
    let id: Int
    let title: String
    let readyInMinutes, servings: Int?
    let image: String?
    let summary: String?
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
        case vegetarian, vegan, glutenFree, veryHealthy, cheap, gaps, aggregateLikes, spoonacularScore, healthScore, sourceName, pricePerServing, extendedIngredients, id, title, readyInMinutes, servings
        case image, summary, cuisines, dishTypes, diets, occasions, instructions, analyzedInstructions
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
    let number: Int?
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

extension Recipe {
    
    public init(managedObject: RecipeLocalObject) {
               id = managedObject.id
               title = managedObject.title
               readyInMinutes = managedObject.readyInMinutes
               extendedIngredients = managedObject.extendedIngredients
               spoonacularScore = managedObject.spoonacularScore
               image = managedObject.image
               analyzedInstructions = managedObject.analyzedInstructions
               servings = managedObject.servings
        aggregateLikes = managedObject.aggregateLikes
        vegan = managedObject.vegan
        vegetarian = managedObject.vegetarian
        cheap = managedObject.cheap
        gaps = managedObject.gaps
        sourceName = managedObject.sourceName
        healthScore = managedObject.healthScore
        cuisines = managedObject.cuisines
        summary = managedObject.summary
        originalID = managedObject.originalID
        preparationMinutes = managedObject.preparationMinutes
        glutenFree = managedObject.glutenFree
        cookingMinutes = managedObject.cookingMinutes
        pricePerServing = managedObject.pricePerServing
        spoonacularSourceURL = managedObject.spoonacularSourceURL
        instructions = managedObject.instructions
        veryHealthy = managedObject.veryHealthy
        diets = managedObject.diets
        occasions = managedObject.occasions
        dishTypes = managedObject.dishTypes
    }
    
    public  func managedObject() -> RecipeLocalObject {
        let recipeSaved = RecipeLocalObject()
        recipeSaved.id = self.id
        recipeSaved.title = self.title
        recipeSaved.readyInMinutes = self.readyInMinutes ?? 10
        recipeSaved.extendedIngredients = self.extendedIngredients!
        recipeSaved.spoonacularScore = self.spoonacularScore ?? 20
        recipeSaved.image = self.image ?? ""
        recipeSaved.analyzedInstructions = self.analyzedInstructions ?? []
        recipeSaved.servings = self.servings ?? 2
        recipeSaved.aggregateLikes = self.aggregateLikes ?? 10
        recipeSaved.vegan = self.vegan ?? false
        recipeSaved.vegetarian = self.vegetarian ?? false
        recipeSaved.cheap = self.cheap ?? true
        recipeSaved.gaps = self.gaps ?? ""
        recipeSaved.sourceName = self.sourceName ?? ""
        recipeSaved.healthScore = self.healthScore ?? 0
        recipeSaved.cuisines = self.cuisines ?? []
        recipeSaved.summary = self.summary ?? ""
        recipeSaved.originalID = self.originalID
        recipeSaved.preparationMinutes = self.preparationMinutes ?? 0
        recipeSaved.glutenFree = self.glutenFree ?? false
        recipeSaved.cookingMinutes = self.cookingMinutes ?? 0
        recipeSaved.pricePerServing = self.pricePerServing
        recipeSaved.spoonacularSourceURL = self.spoonacularSourceURL
        recipeSaved.instructions = self.instructions
        recipeSaved.veryHealthy = self.veryHealthy
        recipeSaved.diets = self.diets
        recipeSaved.dishTypes = self.dishTypes
        recipeSaved.occasions = self.occasions
        return recipeSaved
    }
    
}
