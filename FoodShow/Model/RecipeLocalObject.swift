//
//  RecipeLocalObject.swift
//  FoodShow
//
//  Created by Sergey Vakhrin on 02.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//
import UIKit
import RealmSwift
class RecipeLocalObject : Object{
    
    @objc dynamic var vegetarian: Bool = false
    @objc dynamic var vegan: Bool =  false
    @objc dynamic var glutenFree: Bool = false
    @objc dynamic var dairyFree: Bool = false
    dynamic var veryHealthy:Bool?
    @objc dynamic var cheap:Bool = false
    @objc dynamic var veryPopular:Bool = false
    @objc dynamic var sustainable: Bool = false
    @objc dynamic var weightWatcherSmartPoints: Int = 0
    @objc dynamic var gaps: String = ""
    @objc dynamic var lowFodmap: Bool = false
    @objc dynamic var aggregateLikes: Int = 0
    @objc dynamic var spoonacularScore: Int = 0
    @objc dynamic var healthScore: Int = 0
    @objc dynamic var creditsText: String = ""
    @objc dynamic var license: String = ""
    @objc dynamic var sourceName: String = ""
    dynamic var pricePerServing: Double?
    dynamic var extendedIngredients: [ExtendedIngredient] = []
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var readyInMinutes: Int = 0
    @objc dynamic var servings: Int = 0
    @objc dynamic var sourceURL: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var imageType: String = ""
    @objc dynamic var summary: String = ""
    dynamic var cuisines: [String] = []
    dynamic var dishTypes: [String]?
     dynamic var diets: [String]?
     dynamic var occasions: [String]?
    dynamic var instructions: String?
    dynamic var analyzedInstructions: [AnalyzedInstruction] = []
    dynamic var originalID: JSONNull?//
    @objc dynamic var spoonacularSourceURL: String?
    @objc dynamic var preparationMinutes: Int = 0
    @objc dynamic var cookingMinutes: Int = 0
    // dynamic var isFav: Bool = false


}
