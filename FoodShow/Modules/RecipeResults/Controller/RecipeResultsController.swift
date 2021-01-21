//
//  ViewController.swift
//  GitHubJobsApiCourse
//
//  Created by Eugene Berezin on 12/21/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class ResultsViewController: UICollectionViewController, UISearchBarDelegate, LikeDelegate, UIPopoverPresentationControllerDelegate, FilterApplyDelegate{
    
    func filterApplied(filter: Filter) {
        self.filter = filter
        print(filter.maxTime)
    }
    
    
    func likeButtonTapped(_ recipeId: Int) {
        var result: [Recipe] = []
        for recipe in resipeResults {
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
    
    private let cellId = "searchCellID"
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var resipeResults = [Recipe]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Food"
        let backroundColor = hexStringToUIColor(hex: "0A202B")
        collectionView.backgroundColor = backroundColor
        extendedLayoutIncludesOpaqueBars = true
        self.edgesForExtendedLayout = UIRectEdge.all
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: cellId)
        collectionView!.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
        setupSearchBar()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.recipeNotification),
            name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
            object: nil)
    }
    
    
    @objc func recipeNotification(notification: Notification){
            if let result = notification.object as? Recipe {
                if let i = resipeResults.firstIndex(where: { $0.id == result.id }) {
                    resipeResults[i].isFav = result.isFav
                    self.collectionView.reloadData()
                }
            }

    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layoutView.itemSize = CGSize(width: (self.view.frame.width/2)-22, height: (self.view.frame.width/1.65))
    }
    
    lazy var layoutView: UICollectionViewFlowLayout = {
     let layout = UICollectionViewFlowLayout()
     layout.minimumInteritemSpacing = 12
     layout.minimumLineSpacing = 16
     layout.scrollDirection = .vertical
     return layout
    }()
    
    let backroundColor = hexStringToUIColor(hex: "0A202B")
        
    private func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.showsBookmarkButton = true
        searchController.searchBar.setImage(UIImage(named: "filterSelected"), for: .bookmark, state: .normal)
                
        
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        textFieldInsideSearchBar?.placeholder = "Food name"
    }
    
    var filter = Filter()
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        let popoverVC = FilterViewController(filter: self.filter)
        popoverVC.modalPresentationStyle = .popover
        popoverVC.popoverPresentationController?.permittedArrowDirections = .up
        popoverVC.popoverPresentationController?.delegate = self
        popoverVC.delegate = self
        self.present(popoverVC, animated: true, completion: nil)
    }
    
    
    var timer: Timer?
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let foodName = searchController.searchBar.text {
            timer?.invalidate()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [self] (_) in
                
                NetworkService.request(for: ResultSearch.self, router: Router.getSearch,id: 0, params: [
                                        URLQueryItem(name: "query", value: foodName),URLQueryItem(name: "cuisine", value: filter.activeCuisinesList.joined(separator: ",")),
                                        URLQueryItem(name: "type", value: filter.activeTypeList.joined(separator: ",")),URLQueryItem(name: "diet", value: filter.activeDietList.joined(separator: ",")),URLQueryItem(name: "intolerances", value: filter.activeIntoleranceList.joined(separator: ",")),URLQueryItem(name: "maxReadyTime", value: String(filter.maxTime))]) { (result: ResultSearch) in
                    let RL = RecipeLocalService()
                    self.resipeResults = RL.checkIsFav(with: result.results)

                    self.collectionView.reloadData()
                 }
            })
            
            
        }
        
    }
    
    
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (self.resipeResults.count == 0) {
               self.collectionView.setEmptyMessage("Nothing to show :(")
           } else {
               self.collectionView.restore()
           }

           return self.resipeResults.count
           //return recipes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! RecipeCell
        cell.delegate = self
        cell.backgroundColor = backroundColor
        cell.configure(recipe: resipeResults[indexPath.row])
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/1.5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = RecipeDetailViewController(recipe: resipeResults[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    init() {
           super.init(collectionViewLayout: UICollectionViewFlowLayout())
           collectionView?.collectionViewLayout = layoutView
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}

