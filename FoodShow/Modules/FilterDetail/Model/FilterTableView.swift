//
//  FilterTableView.swift
//  FoodShow
//
//  Created by Бекболат Азамат on 21.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//
import UIKit

typealias FilterListConfig = TableCellConfigurator<FilterList, (String,Filter)>
typealias TimerCellConfig = TableCellConfigurator<TimerSliderCell, Int>
typealias DoneButtonCellConfig = TableCellConfigurator<DoneButtonCell, String>

class FilterTableViewModel {
    
    func getFilterItems(filter:Filter!) -> [CellConfigurator]{
        var items: [CellConfigurator] = []
        
        items.append(FilterListConfig.init(item:("cuisine",filter)))
        items.append(FilterListConfig.init(item:("type",filter)))
        items.append(FilterListConfig.init(item:("diet",filter)))
        items.append(FilterListConfig.init(item:("intolerances",filter)))
        items.append(TimerCellConfig.init(item: filter.maxTime))
        items.append(DoneButtonCellConfig.init(item: "Apply"))
        
        return items
    }
}

