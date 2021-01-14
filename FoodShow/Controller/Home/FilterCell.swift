//
//  FilterCell.swift
//  FoodShowA
//
//  Created by Aigerim Ilipova on 8.01.2021.
//

import UIKit

class FilterCell: UICollectionViewCell {

    @IBOutlet weak var filterCellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell ( name: String ) {
        self.filterCellLabel.text = name
    }
    
}
