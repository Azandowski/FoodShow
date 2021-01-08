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
    var recipe: Recipe!
    var titleLike: String!
    
    init(recipe:Recipe,titleLike: String) {
        self.recipe = recipe
        items.append(DetailStackConfig.init(item: recipe))
        items.append(ButtonCellConfig.init(item: titleLike))
        items.append(IngredientsCellConfig.init(item: recipe))
        if recipe.analyzedInstructions!.count > 0{
            for step in recipe.analyzedInstructions![0].steps {
                       items.append(StepCellConfig.init(item: step))
                   }
        }
        items.append(SimilarListConfig.init(item: recipe.id))
    }
    
    var items: [CellConfigurator] = []
    
    func changeLabel(val:String){
        titleLike = val
    }
}

