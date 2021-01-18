//
//  HomeRecCell.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 19.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import UIKit

class HomeRecCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var recImage: UIImageView!
    @IBOutlet weak var recTitle: UILabel!
    @IBOutlet weak var recButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.layer.cornerRadius = 16
        recImage.layer.cornerRadius = 16
        
    }
    
    func createCell ( _ rec: Recipe ) {
        recImage.image = UIImage(named: rec.image ?? "demoImg")
        recTitle.text = rec.title
        
    }

}
