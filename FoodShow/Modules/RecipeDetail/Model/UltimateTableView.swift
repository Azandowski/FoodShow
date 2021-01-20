//
//  UltimateTableView.swift
//  FoodShow
//
//  Created by AzaDev on 1/2/21.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import UIKit

typealias MessageCellConfig = TableCellConfigurator<MessageCell, String>
typealias ImageCellConfig = TableCellConfigurator<ImageCell, URL?>
typealias StepCellConfig = TableCellConfigurator<StepCell, Step?>
typealias DetailStackConfig = TableCellConfigurator<DetailStackView, Recipe>
typealias SimilarListConfig = TableCellConfigurator<SimilarListCell, Int>
typealias ButtonCellConfig = TableCellConfigurator<ButtonCell, String>
typealias IngredientsCellConfig = TableCellConfigurator<IngredientsStackView, Recipe>


class TableViewModel {
    
    func getRecipeItems(recipe: Recipe!) -> [CellConfigurator]{
        var items: [CellConfigurator] = []
        
        if(recipe.spoonacularScore != nil){
           items = returnItem(recipe: recipe)
        }
        
        return items
    }
    
    func returnItem(recipe: Recipe!)-> [CellConfigurator]{
        var items: [CellConfigurator] = []
        items.append(DetailStackConfig.init(item: recipe))
        items.append(IngredientsCellConfig.init(item: recipe))
        items.append(ButtonCellConfig.init(item: recipe.isFav ? "Delete from Favorites"  :  "Add to Favorites"))
        if recipe.analyzedInstructions!.count > 0{
            for step in recipe.analyzedInstructions![0].steps {
                       items.append(StepCellConfig.init(item: step))
                   }
        }
        items.append(SimilarListConfig.init(item: recipe.id))
        return items
    }
}

