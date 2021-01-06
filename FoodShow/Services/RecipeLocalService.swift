//
//  RecipeLocalService.swift
//  FoodShow
//
//  Created by Sergey Vakhrin on 03.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//
import Foundation
import RealmSwift

enum NetworkError: Error {
    case notFound
    case parsingError
}

//интерфейс
protocol RecipeService: AnyObject {
    func getAllRecipe(completion: @escaping (Result<[RecipeLocalObject], NetworkError>) -> Void)
    func saveRecipe(with recipesList: [RecipeLocalObject])
    func removeRecipes(with resipeId: Int)
    func convertToRecipeLocalObject(with recipes: [Recipe]) -> [RecipeLocalObject]
}


final class RecipeLocalService: RecipeService {
    
    func removeRecipes(with resipeId: Int) {
        
        let filterQuery = String(format: "%@%d", "id = ", resipeId)
        do {
            let realm = try! Realm()
            print("try....")
            let realmObjectById = realm.objects(RecipeLocalObject.self).filter(filterQuery)
            print(realmObjectById)
            try! realm.write{
                realm.delete(realmObjectById)
            }
            
        } catch {
            print(error)
        }
        
    }
    
    func convertToRecipeLocalObject(with recipes: [Recipe]) -> [RecipeLocalObject] {
      
        var result = [RecipeLocalObject]()
        for recipe in recipes {
            let recipeL = RecipeLocalObject()
            recipeL.aggregateLikes = recipe.aggregateLikes!
            recipeL.cheap = recipe.cheap!
            recipeL.cookingMinutes = recipe.cookingMinutes ?? 0
            recipeL.creditsText = recipe.creditsText ?? ""
            recipeL.cuisines = recipe.cuisines!
            recipeL.dairyFree = recipe.dairyFree!
            recipeL.diets = recipe.diets!
            recipeL.dishTypes = recipe.dishTypes!
            recipeL.gaps  = recipe.gaps!
            recipeL.glutenFree = recipe.glutenFree!
            recipeL.healthScore  = recipe.healthScore!
            recipeL.id = recipe.id
            recipeL.image  = recipe.image!
            recipeL.imageType =  recipe.imageType!
            recipeL.instructions = recipe.instructions!
            recipeL.license = recipe.license!
            recipeL.lowFodmap = recipe.lowFodmap!
            recipeL.occasions = recipe.occasions!
            recipeL.preparationMinutes = recipe.preparationMinutes ?? 0
            recipeL.pricePerServing = recipe.pricePerServing!
            recipeL.readyInMinutes = recipe.readyInMinutes
            recipeL.servings = recipe.servings
            recipeL.sourceName = recipe.sourceName!
            recipeL.sourceURL = recipe.sourceURL!
            recipeL.spoonacularScore = recipe.spoonacularScore!
            recipeL.spoonacularSourceURL = recipe.spoonacularSourceURL!
            recipeL.summary = recipe.summary!
            recipeL.sustainable = recipe.sustainable!
            recipeL.title = recipe.title
            recipeL.vegan = recipe.vegan!
            recipeL.vegetarian = recipe.vegetarian!
            recipeL.veryHealthy = recipe.veryHealthy!
            recipeL.veryPopular = recipe.veryPopular!
            recipeL.weightWatcherSmartPoints = recipe.weightWatcherSmartPoints!
            recipeL.extendedIngredients = recipe.extendedIngredients ?? []
            recipeL.analyzedInstructions = recipe.analyzedInstructions ?? []
            recipeL.originalID = recipe.originalID
  
            result.append(recipeL)
        }
        return result
    }
    
    func saveRecipe(with recipesList: [RecipeLocalObject]) {
        do {
            let realm = try! Realm()
            try realm.write {
                realm.add(recipesList)
            }
        } catch {
            print(error)
        }
   
    }
    
    func getAllRecipe(completion: @escaping (Result<[RecipeLocalObject], NetworkError>) -> Void) {
    
        var result = [RecipeLocalObject]()
        do {
            let realm = try Realm()
            let results = realm.objects(RecipeLocalObject.self)
            result.append(contentsOf: results)
        } catch {
            guard let nError = error as? NetworkError else {
                return
            }
            completion(.failure(nError))
        }
            completion(.success(result))
        
    }
   
    
}
