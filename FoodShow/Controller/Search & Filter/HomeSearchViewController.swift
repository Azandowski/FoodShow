//
//  HomeSearchViewController.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 19.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import UIKit

class HomeSearchViewController: UIViewController, UISearchBarDelegate {
    
    let searchTexts =[ "Cake", "Recipe Test", "Salad" ]
    var filteredData = [String]!

    @IBOutlet weak var searchBarS: UISearchBar!
    @IBOutlet weak var filterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarS.delegate = self
        
    }
    
    
     // MARK: Search
    
    func searcBar (_ searchBar: UISearchBar, textDidChange searchText: String){
        
        
    }
    
    

}
