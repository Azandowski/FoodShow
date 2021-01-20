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
    func getRecipeById(with recipeId: Int ,completion: @escaping (Result<[RecipeLocalObject], NetworkError>) -> Void)
    func saveRecipe(with recipesList: [RecipeLocalObject])
    func removeRecipes(with resipeId: Int)
    func convertToRecipeLocalObject(with recipes: [Recipe]) -> [RecipeLocalObject]
}


final class RecipeLocalService: RecipeService {

    func removeRecipes(with recipeId: Int) {
        
        let filterQuery = String(format: "%@%d", "id = ", recipeId)
        do {
            let realm = try! Realm()
            let realmObjectById = realm.objects(RecipeLocalObject.self).filter(filterQuery)
            try! realm.write{
                realm.delete(realmObjectById)
            }
        }
        
    }
    
    func convertToRecipeLocalObject(with recipes: [Recipe]) -> [RecipeLocalObject] {
      
        var result = [RecipeLocalObject]()
        for recipe in recipes {
            let recipeL = RecipeLocalObject()
            recipeL.aggregateLikes = recipe.aggregateLikes ?? 0
            recipeL.cheap = recipe.cheap ?? false
            recipeL.cookingMinutes = recipe.cookingMinutes ?? 0
            recipeL.cuisines = recipe.cuisines ?? [""]
            recipeL.diets = recipe.diets ?? [""]
            recipeL.dishTypes = recipe.dishTypes ?? [""]
            recipeL.gaps  = recipe.gaps ?? ""
            recipeL.glutenFree = recipe.glutenFree ?? false
            recipeL.healthScore  = recipe.healthScore ?? 0
            recipeL.id = recipe.id
            recipeL.image  = recipe.image ?? "https://spoonacular.com/recipeImages/716298-556x370.jpg"
            recipeL.instructions = recipe.instructions ?? ""
            recipeL.occasions = recipe.occasions ?? [""]
            recipeL.preparationMinutes = recipe.preparationMinutes ?? 0
            recipeL.pricePerServing = recipe.pricePerServing ?? 0.0
            recipeL.readyInMinutes = recipe.readyInMinutes ?? 10
            recipeL.servings = recipe.servings ?? 2
            recipeL.sourceName = recipe.sourceName ?? ""
            recipeL.spoonacularScore = recipe.spoonacularScore ??  -10
            recipeL.summary = recipe.summary ?? ""
            recipeL.title = recipe.title
            recipeL.vegan = recipe.vegan ?? false
            recipeL.vegetarian = recipe.vegetarian ?? false
            recipeL.veryHealthy = recipe.veryHealthy ?? false
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
    
    
    func getRecipeById(with recipeId: Int ,completion: @escaping (Result<[RecipeLocalObject], NetworkError>) -> Void){
        var result = [RecipeLocalObject]()
        let filterQuery = String(format: "%@%d", "id = ", recipeId)
        do {
            let realm = try Realm()
            let results = realm.objects(RecipeLocalObject.self).filter(filterQuery);
            result.append(contentsOf: results)
        } catch {
            guard let nError = error as? NetworkError else {
                return
            }
            completion(.failure(nError))
        }
            completion(.success(result))
        
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
    
    public func extractRecipes () -> [Recipe] {
        let realm = try! Realm()
        let models = realm.objects(RecipeLocalObject.self)
        return Array(models).map {
            //print($0.id)
            return Recipe(managedObject: $0)
        }
    }
    public func checkIsFav(with recipes: [Recipe]) -> [Recipe]{
                           
        let realm = try! Realm()
        let models = realm.objects(RecipeLocalObject.self)
        var localRecipe = recipes
        let result = Array(models).map { return Recipe(managedObject: $0) }
        
        for (index,item) in localRecipe.enumerated(){
            if result.firstIndex(where: { $0.id == item.id }) != nil {
                localRecipe[index].isFav = true
            }
        }
        return localRecipe
        }
    
}
