//
//  FilterVC.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 19.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import UIKit

let data = ["All", "Food", "Drink", "Salad"]

class FilterVC: UIViewController {

    @IBOutlet weak var filterCollections: UICollectionView!
    @IBOutlet weak var filterTimeSlider: UISlider!
    
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var done: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        filterCollections.delegate = self
        filterCollections.dataSource = self
        
        let filterNib = UINib(nibName: "FilterCategoryCell", bundle: nil)
        
        filterCollections.register(filterNib, forCellWithReuseIdentifier: "FilterCategoryCellID")
        
        cancel.layer.cornerRadius = 30
        done.layer.cornerRadius = 30
        
    }
    
    @IBAction func cancelClick(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension FilterVC: UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = filterCollections.dequeueReusableCell(withReuseIdentifier: "FilterCategoryCellID", for: indexPath) as? FilterCategoryCell
        
        cell?.createFilter(data[indexPath.row])
        
        return cell!
        
    }
    
    
}
