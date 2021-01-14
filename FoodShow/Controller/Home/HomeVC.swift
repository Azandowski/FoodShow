//
//  HomeVC.swift
//  FoodShowA
//
//  Created by Aigerim Ilipova on 9.01.2021.
//

import UIKit


let filtersName = ["All", "Foods", "Drinks", "Snacks", "Sauce", "Olololo", "Foods", "Drinks", "Snacks", "Sauce", "Olololo"]


class HomeVC: UIViewController {
    
    @IBOutlet weak var filterMenu: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.filterMenu.register(UINib(nibName: "FilterCell",
                                       bundle: nil),
                                 forCellWithReuseIdentifier: "FilterCell")
        
        self.filterMenu.dataSource = self
        self.filterMenu.delegate = self
        
    }
    

}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filtersName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = filterMenu.dequeueReusableCell(withReuseIdentifier: "FilterCell",
                                                  for: indexPath) as! FilterCell
        
        let name =  filtersName[indexPath.row]
        
        cell.setupCell(name: name )
        
        return cell
    }
    
}
