//
//  FilterCategoryCell.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 19.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import UIKit

class FilterCategoryCell: UICollectionViewCell {

    @IBOutlet weak var filterBut: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
    
    func createFilter ( _ filter: String ) {
        
        
        filterBut.setTitle( filter, for: .normal)
        
    
    }

}
