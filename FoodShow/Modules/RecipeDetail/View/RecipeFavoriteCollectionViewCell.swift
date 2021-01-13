//
//  RecipeFavoriteCollectionViewCell.swift
//  FoodShow
//
//  Created by Sergey Vakhrin on 11.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import UIKit

class RecipeFavoriteCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecipeFavoriteCollectionViewCell"
    
    public var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.backgroundColor = UIColor.white
        
        let images = [
         UIImage(named: "favorite"),
         UIImage(named: "unfavorite")
        ].compactMap({ $0 })
        
       
        imageView.image = images.randomElement()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
       // imageView.image =  nil
    }
     
}
