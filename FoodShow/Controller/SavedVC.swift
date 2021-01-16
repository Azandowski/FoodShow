//
//  SavedVC.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 26.12.2020.
//  Copyright © 2020 TeamOfFour. All rights reserved.
//

import UIKit

class SavedVC: UIViewController, LikeDelegate{
    
    func likeButtonTapped(_ recipeId: Int) {
                let RL = RecipeLocalService()
        var recipe = recipes.first { (recipe) -> Bool in
            recipe.id == recipeId
        }
        recipe?.isFav = false
        RL.removeRecipes(with: recipeId)
        getLocalFavs()
        
        DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
                        object: recipe  )
                }
    }
    
    var items: [RecipeLocalObject] = []
    var recipes: [Recipe] = []

    
    lazy var collectionView: UICollectionView = {
              let layout = UICollectionViewFlowLayout()
              layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
              layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (self.view.frame.width/2)-24, height: (self.view.frame.width/1.7))
              let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
              cv.backgroundColor = backroundColor
              cv.register(RecipeCell.self, forCellWithReuseIdentifier: "cellFav")
           return cv
          }()
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = false
       }
    
    let backroundColor = hexStringToUIColor(hex: "0A202B")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        self.view.backgroundColor = backroundColor
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(16)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalToSuperview()
        }
        getLocalFavs()
        
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
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        collectionView.frame = view.bounds
    }
}
extension SavedVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return recipes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFav", for: indexPath) as! RecipeCell
        cell.delegate = self
        cell.backgroundColor = backroundColor
        cell.configure(recipe: recipes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/1.5)
    }
    
}
