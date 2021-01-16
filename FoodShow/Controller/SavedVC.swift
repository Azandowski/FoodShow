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
              layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 16
              layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (self.view.frame.width/2)-22, height: (self.view.frame.width/1.65))
              let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
              cv.backgroundColor = backroundColor
              cv.register(RecipeCell.self, forCellWithReuseIdentifier: "cellFav")
           return cv
          }()
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.topItem?.title = "Избранные"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
       
       override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isTranslucent = false
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
        
        if (self.recipes.count == 0) {
               self.collectionView.setEmptyMessage("Nothing to show :(")
           } else {
               self.collectionView.restore()
           }

           return self.recipes.count
           //return recipes.count
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

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 22)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
