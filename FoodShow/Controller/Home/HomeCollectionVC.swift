//
//  HomeCollectionVC.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 19.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionVC: UICollectionViewController{
    
    let networkService = NetworkService()
    var collectionTitleString: String = ""
    var items: [Recipe] = []
    var test: Int?
    
    let recItem = Recipe(vegetarian: true,
                         vegan: true,
                         glutenFree: true,
                         veryHealthy: true,
                         cheap: true,
                         gaps: "true",
                         aggregateLikes: 33,
                         spoonacularScore: 3,
                         healthScore: 3,
                         sourceName: "Recipe Test",
                         extendedIngredients: [],
                         id: 12,
                         title: "Recipe Test",
                         readyInMinutes: 30,
                         servings: 2,
                         image: "demoImg",
                         summary: "demoImg",
                         cuisines: [],
                         dishTypes: [],
                         diets: [],
                         occasions: [],
                         instructions: "demoImg",
                         analyzedInstructions: [],
                         originalID: nil,
                         spoonacularSourceURL: "demoImg",
                         preparationMinutes: 2,
                         cookingMinutes: 2)
    let recItemTwo = Recipe(vegetarian: true,
                         vegan: true,
                         glutenFree: true,
                         veryHealthy: true,
                         cheap: true,
                         gaps: "true",
                         aggregateLikes: 33,
                         spoonacularScore: 3,
                         healthScore: 3,
                         sourceName: "Recipe Test",
                         extendedIngredients: [],
                         id: 12,
                         title: "Recipe Test",
                         readyInMinutes: 10,
                         servings: 2,
                         image: "demoImg",
                         summary: "demoImg",
                         cuisines: [],
                         dishTypes: [],
                         diets: [],
                         occasions: [],
                         instructions: "demoImg",
                         analyzedInstructions: [],
                         originalID: nil,
                         spoonacularSourceURL: "demoImg",
                         preparationMinutes: 2,
                         cookingMinutes: 2)
    let recItemThree = Recipe(vegetarian: true,
                         vegan: true,
                         glutenFree: true,
                         veryHealthy: true,
                         cheap: true,
                         gaps: "true",
                         aggregateLikes: 33,
                         spoonacularScore: 3,
                         healthScore: 3,
                         sourceName: "Recipe Test",
                         extendedIngredients: [],
                         id: 12,
                         title: "Cake",
                         readyInMinutes: 60,
                         servings: 2,
                         image: "demoImg",
                         summary: "demoImg",
                         cuisines: [],
                         dishTypes: [],
                         diets: [],
                         occasions: [],
                         instructions: "demoImg",
                         analyzedInstructions: [],
                         originalID: nil,
                         spoonacularSourceURL: "demoImg",
                         preparationMinutes: 2,
                         cookingMinutes: 2)
    let recItemFour = Recipe(vegetarian: true,
                         vegan: true,
                         glutenFree: true,
                         veryHealthy: true,
                         cheap: true,
                         gaps: "true",
                         aggregateLikes: 33,
                         spoonacularScore: 3,
                         healthScore: 3,
                         sourceName: "Recipe Test",
                         extendedIngredients: [],
                         id: 12,
                         title: "Salad",
                         readyInMinutes: 25,
                         servings: 2,
                         image: "demoImg",
                         summary: "demoImg",
                         cuisines: [],
                         dishTypes: [],
                         diets: [],
                         occasions: [],
                         instructions: "demoImg",
                         analyzedInstructions: [],
                         originalID: nil,
                         spoonacularSourceURL: "demoImg",
                         preparationMinutes: 2,
                         cookingMinutes: 2)
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nibCell = UINib(nibName: "HomeRecCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "HomeRecCellID")

        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        items.append(recItem)
        items.append(recItemTwo)
        items.append(recItemThree)
        items.append(recItemFour)
        
//        NetworkService.request(router: Router.getRandom,id: 0) { (result: [String? : [Recipe]]) in
//            self.items = result["recipes"]!
//            self.collectionView.reloadData()
//         }
//        
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(self.recipeNotification),
//            name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
//            object: nil)

    }
    
    @objc func recipeNotification(notification: Notification){
            if let result = notification.object as? Recipe {
                if let i = items.firstIndex(where: { $0.id == result.id }) {
                    items[i].isFav = result.isFav
                    self.collectionView.reloadData()
                }
            }
            
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return items.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeRecCellID", for: indexPath) as? HomeRecCell
        
       
    
        cell!.createCell( items[indexPath.row] )
        
    
        return cell!
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

