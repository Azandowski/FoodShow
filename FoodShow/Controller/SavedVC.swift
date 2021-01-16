//
//  SavedVC.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 26.12.2020.
//  Copyright © 2020 TeamOfFour. All rights reserved.
//

import UIKit

class SavedVC: UIViewController{
    
    var items: [RecipeLocalObject] = []
    var recipes: [Recipe] = []
    lazy var collectionView: UICollectionView = {
              let layout = UICollectionViewFlowLayout()
              layout.minimumInteritemSpacing = 24
              layout.scrollDirection = .vertical
              layout.itemSize = CGSize(width: 200, height: 220)
              let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
              cv.backgroundColor = .black
              cv.register(RecipeCell.self, forCellWithReuseIdentifier: "cellFav")
           return cv
          }()
    
    @objc func buttonActions(sender: UIButton!){
        print("HI")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        getLocalFavs()
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.recipeNotification),
            name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
            object: nil)
    }
    
    @objc func recipeNotification(notification: Notification){
       getLocalFavs()
       collectionView.reloadData()
        
    }
    
    func getLocalFavs(){
        let RL = RecipeLocalService()
        self.recipes = RL.extractRecipes()
        collectionView.reloadData()
    }

}


extension SavedVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFav", for: indexPath) as! RecipeCell
        cell.backgroundColor = .black
        (cell).configure(recipe: recipes[indexPath.row])
        cell.likeButton.addTarget(self, action: #selector(buttonActions), for: .touchUpInside)
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width/2)-3,
            height: (view.frame.size.width/2)-3
            )
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = RecipeDetailViewController(recipe: recipes[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true) 

//        let RL = RecipeLocalService()
//        let recipeId = recipes[indexPath.row].id
//        var recipe = recipes[indexPath.row]
//        recipe.isFav = false
//        RL.removeRecipes(with: recipeId)
//        getLocalFavs()
//        
//        DispatchQueue.main.async {
//            NotificationCenter.default.post(
//                name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
//                object: recipe  )
//        }
    }
}
