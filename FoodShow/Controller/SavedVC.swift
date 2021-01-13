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
    func getLocalFavs(){
        let RL = RecipeLocalService()
        self.recipes = RL.extractRecipes()
        collectionView.reloadData()
    }
    func getLocalRecipes() {
        let RL = RecipeLocalService()
        RL.getAllRecipe(completion: { result in
                        switch result {
                        case .failure(let error):
                            print(error)
                        case .success(let recipe):
                            self.items = recipe
                        }})
    }
    
    @objc func recipeNotification(notification: Notification){
        print("savedVC")
        getLocalRecipes()
//        collectionView.reloadData()
        
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
        cell.backgroundColor = .black
        (cell).configure(recipe: recipes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
}
