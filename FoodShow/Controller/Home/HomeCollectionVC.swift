//
//  HomeCollectionVC.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 19.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeCollectionVC: UICollectionViewController, LikeDelegate{
    
    func likeButtonTapped(_ recipeId: Int) {
        var result: [Recipe] = []
        for recipe in items {
            if recipe.id == recipeId{
                result.append(recipe)
            }
        }
        let RL = RecipeLocalService()
        if result[0].isFav{
            RL.removeRecipes(with: recipeId)
            result[0].isFav = false
            print("no, \(result[0].id)")        }
        else{
            let newFavoriteRecipe = RL.convertToRecipeLocalObject(with: result)
            RL.saveRecipe(with: newFavoriteRecipe)

            result[0].isFav=true
            print("yes, \(result[0].id)")
        }
       
        DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
                        object: result[0] )
                }
  
    }
    
    let networkService = NetworkService()
    var collectionTitleString: String = ""
    var items: [Recipe] = []
    var test: Int?
    
    let backroundColor = hexStringToUIColor(hex: "0A202B")

    lazy var layoutView: UICollectionViewFlowLayout = {
     let layout = UICollectionViewFlowLayout()
     layout.minimumInteritemSpacing = 12
     layout.minimumLineSpacing = 16
     layout.scrollDirection = .vertical
     return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.request(for: Recipes.self, router: Router.getRandom,id: 0, params: [], completion: { [self] (result: Recipes) in
            let RL = RecipeLocalService()
            items = RL.checkIsFav(with: result.recipes)
            self.collectionView.reloadData()
            
         })
        collectionView.backgroundColor = backroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView?.collectionViewLayout = layoutView
        collectionView!.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
        
        self.collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: "cellMain")
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.recipeNotification),
            name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
            object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutView.itemSize = CGSize(width: (self.view.frame.width/2)-22, height: (self.view.frame.width/1.65))
    }
    
    @objc func recipeNotification(notification: Notification){
            if let result = notification.object as? Recipe {
                if let i = items.firstIndex(where: { $0.id == result.id }) {
                    items[i].isFav = result.isFav
                    self.collectionView.reloadData()
                }
            }
      //  items.forEach{print("\($0.id) , \($0.isFav)")}

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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellMain", for: indexPath) as! RecipeCell
        cell.delegate = self
        cell.backgroundColor = backroundColor
        cell.configure(recipe: items[indexPath.row])
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ResultsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
//
//    let vc = RecipeDetailViewController(recipe: items[indexPath.row])
//    self.navigationController?.pushViewController(vc, animated: true)
    
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

