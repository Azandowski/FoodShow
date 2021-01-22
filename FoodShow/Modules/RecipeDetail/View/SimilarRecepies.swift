//
//  SimilarRecepies.swift
//  FoodShow
//
//  Created by Бекболат Азамат on 22.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import Foundation
import UIKit

class SimilarListCell: UITableViewCell, ConfigurableCell, LikeDelegate {
    
    
    func likeButtonTapped(_ recipeId: Int) {
        var result: [Recipe] = []
        let recipe = recipesAll!.first { (recipe) -> Bool in recipe.id == recipeId }!
        result.append(recipe)
        let RL = RecipeLocalService()
        if result[0].isFav{
            RL.removeRecipes(with: recipeId)
            result[0].isFav = false
            }
        else {
            let newFavoriteRecipe = RL.convertToRecipeLocalObject(with: result)
            RL.saveRecipe(with: newFavoriteRecipe)
            result[0].isFav=true
            }
        
        DispatchQueue.main.async {
                    NotificationCenter.default.post(
                        name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
                        object: result[0] )
                }
        
        similarCollectionView.reloadData()
    }
    
    var recipesAll: [Recipe]?
    
    var navigationController: UINavigationController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(similarCollectionView)
        similarCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(310)
            make.width.equalToSuperview()
        }

        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.recipeNotification),
            name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
            object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func recipeNotification(notification: Notification){
            if let result = notification.object as? Recipe {
                for (index,value) in recipesAll!.enumerated(){
                    if value.id == result.id{
                        recipesAll![index].isFav = result.isFav
                    }
                }
            }
        
        self.similarCollectionView.reloadData()
    }
    
    fileprivate let similarCollectionView: UICollectionView = {
              let layout = UICollectionViewFlowLayout()
              layout.minimumInteritemSpacing = 24
              layout.minimumLineSpacing = 24
              layout.scrollDirection = .horizontal
              layout.itemSize = CGSize(width: 200, height: 270)
              let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
              cv.backgroundColor = .black
              cv.register(RecipeCell.self, forCellWithReuseIdentifier: "cell")
           return cv
          }()
    
    func configure(data id: Int) {
        if(self.recipesAll == nil){
            NetworkService.request(for: RecipeFind.self, router: Router.getSimilar,id: id, params: [], completion: { [self] (result: RecipeFind) in
                let RL = RecipeLocalService()
                self.recipesAll = RL.checkIsFav(with: result)
                self.similarCollectionView.reloadData()
             })

        }
    }
}

extension SimilarListCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if recipesAll != nil{
           return recipesAll!.count
         }else{
            return 0
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecipeCell
        cell.delegate = self
        cell.layer.cornerRadius = 12
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        cell.layer.backgroundColor = UIColor.black.cgColor
        cell.layer.masksToBounds = true
        cell.configure(recipe: recipesAll![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = RecipeDetailViewController(recipe: (recipesAll?[indexPath.row])!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
