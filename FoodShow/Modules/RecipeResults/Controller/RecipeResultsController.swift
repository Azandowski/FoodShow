//
//  ViewController.swift
//  GitHubJobsApiCourse
//
//  Created by Eugene Berezin on 12/21/19.
//  Copyright © 2019 Eugene Berezin. All rights reserved.
//

import UIKit

class ResultsViewController: UICollectionViewController, UISearchBarDelegate, LikeDelegate{

    func likeButtonTapped(_ recipeId: Int) {
        
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
        let textFieldInsideSearchBar = searchController.searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        textFieldInsideSearchBar?.placeholder = "Food name"
    }
    
    
    var timer: Timer?
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if let foodName = searchController.searchBar.text {
            timer?.invalidate()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                
                NetworkService.request(for: ResultSearch.self, router: Router.getSearch,id: 0, params: [URLQueryItem(name: "query", value: foodName)]) { (result: ResultSearch) in
                    self.resipeResults = result.results
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
    
    init() {
           super.init(collectionViewLayout: UICollectionViewFlowLayout())
           collectionView?.collectionViewLayout = layoutView
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       


}

