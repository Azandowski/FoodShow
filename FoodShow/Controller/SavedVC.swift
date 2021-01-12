//
//  SavedVC.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 26.12.2020.
//  Copyright © 2020 TeamOfFour. All rights reserved.
//

import UIKit

class SavedVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var items: [RecipeLocalObject] = []
    
    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(RecipeFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: RecipeFavoriteCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        getLocalRecipes()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.recipeNotification),
            name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
            object: nil)
        
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
        collectionView.reloadData()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecipeFavoriteCollectionViewCell.identifier, for: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width/2)-10,
            height: (view.frame.size.width/2)-10
            )
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        let index = indexPath.row
//      DispatchQueue.main.async {
//            NotificationCenter.default.post(
//                name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
//                object: self.items[index])  
//    }
        print("Нажата колонка \(indexPath.section) и строка \(indexPath.row)")
    }
}
