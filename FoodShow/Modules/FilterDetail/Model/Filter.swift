//
//  Fikter.swift
//  FoodShow
//
//  Created by Бекболат Азамат on 21.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import Foundation

struct Filter {
    let cuisinesList = ["African","American","British","Cajun","Caribbean","Chinese","Eastern European","European","French","German","Greek","Indian","Irish","Italian","Japanese","Jewish","Korean","Latin American","Mediterranean","Mexican","Middle Eastern","Nordic","Southern Spanish","Thai","Vietnamese"]
    var activeCuisinesList = [String]()
    let typeList = ["dessert","appetizer","salad","bread","breakfast","soup","beverage","sauce","marinade","drink","snack","fingerfood","main course","side dish"]
    var activeTypeList = [String]()
    let dietList = ["Gluten Free","Ketogenic","Vegetarian","Lacto-Vegetarian","Ovo-Vegetarian","Vegan","Pescetarian","Paleo","Primal","Whole30",]
    var activeDietList = [String]()
    let intoleranceList = ["Dairy","Egg","Gluten","Grain","Peanut","Seafood","Sesame","Shellfish","Soy","Sulfite","Tree Nut","Wheat"]
    var activeIntoleranceList = [String]()
    var maxTime = 240

}
