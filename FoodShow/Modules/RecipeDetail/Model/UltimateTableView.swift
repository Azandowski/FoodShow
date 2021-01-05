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
class TableViewModel {
    var recipe: Recipe!
    
    init(recipe:Recipe) {
        self.recipe = recipe
        for step in recipe.analyzedInstructions[0].steps {
            print(step.step)
            items.append(StepCellConfig.init(item: step))
        }
        items.append(ImageCellConfig.init(item: URL(string: recipe.image ?? "")))
    }
    
    var items: [CellConfigurator] = []
}

