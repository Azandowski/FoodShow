//
//  HomeStaticTableVC.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 28.12.2020.
//  Copyright © 2020 TeamOfFour. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, LikeDelegate, UISearchBarDelegate{
    
    func likeButtonTapped(_ recipeId: Int) {
        var result: [Recipe] = []
        for recipe in recipes {
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
        self.navigationController?.navigationBar.topItem?.title = "FoodShoow"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.backgroundColor = backroundColor
        
    }
    private let searchController = UISearchController(searchResultsController: nil)

    
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.addTarget(self, action: #selector(searchTapped), for: .touchDown)
        textFieldInsideSearchBar?.textColor = .white
        textFieldInsideSearchBar?.placeholder = "Food name"
    }
    
    @objc func searchTapped(sender: UITextField!) {
        print("stranno")
        let vc = ResultsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        NetworkService.request(for: Recipes.self, router: Router.getRandom,id: 0, params: [], completion: { [self] (result: Recipes) in
            let RL = RecipeLocalService()
            recipes = RL.checkIsFav(with: result.recipes)
            self.collectionView.reloadData()
            
         })
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.recipeNotification),
            name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
            object: nil)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupSearchBar()
        
    }
    
    @objc func recipeNotification(notification: Notification){
            if let result = notification.object as? Recipe {
                if let i = recipes.firstIndex(where: { $0.id == result.id }) {
                    recipes[i].isFav = result.isFav
                    self.collectionView.reloadData()
                }
            }
    }
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (self.recipes.count == 0) {
               self.collectionView.setEmptyMessage("Nothing to show :(")
           } else {
               self.collectionView.restore()
           }

           return self.recipes.count
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = RecipeDetailViewController(recipe: recipes[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
