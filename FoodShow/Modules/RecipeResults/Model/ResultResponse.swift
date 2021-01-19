//
//  ResultResponse.swift
//  FoodShow
//
//  Created by Бекболат Азамат on 19.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import Foundation
struct ResultSearch: Codable {
    let results: [Recipe]
    let offset, number, totalResults: Int
}
