//
//  RecipeCell.swift
//  FoodShow
//
//  Created by Бекболат Азамат on 16.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import Foundation
import UIKit

protocol LikeDelegate {
    func likeButtonTapped(_ recipeId: Int)
}

class RecipeCell: UICollectionViewCell{
   
    var delegate: LikeDelegate?
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentView.addSubview(pictureView)
        contentView.addSubview(recipeView)
        contentView.bringSubviewToFront(pictureView)
        
        mainStackVIew.addArrangedSubview(nameLikeStack)
        mainStackVIew.addArrangedSubview(timePersonsStack)
        timePersonsStack.addArrangedSubview(persons)
        timePersonsStack.addArrangedSubview(minute)
        nameLikeStack.addArrangedSubview(titleLbl)
        nameLikeStack.addArrangedSubview(likeButton)
        
        recipeView.addSubview(mainStackVIew)
        mainStackVIew.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        recipeView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(contentView.snp.height).multipliedBy(0.8)
        }

        pictureView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(contentView.snp.width).multipliedBy(0.75)
            make.height.equalTo(pictureView.snp.width).multipliedBy(1.1)

        }
        
        likeButton.addTarget(self,action:#selector(likeTapped),
                             for:.touchUpInside)
    }
    
    @objc func likeTapped(sender:UIButton)
    {
        delegate?.likeButtonTapped(sender.tag)
    }
    
    let mainStackVIew: UIStackView = {
        let stackView          = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let nameLikeStack: UIStackView = {
        let stackView          = UIStackView()
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let timePersonsStack: UIStackView = {
        let stackView          = UIStackView()
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    var recipeView: UIView = {
       let view = UIView()
       view.layer.cornerRadius = 16
       var color1 = hexStringToUIColor(hex: "#757A83")
       view.backgroundColor = color1
       return view
    }()
    
    
    let gradientMaskLayer: CAGradientLayer = {
        let grad = CAGradientLayer()
        grad.colors = [UIColor(red: 0, green: 0, blue: 0, alpha: 0.1),UIColor.clear.cgColor]
        return grad
    }()
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    let secondTextColor = hexStringToUIColor(hex: "BDBDBD")
    lazy var minute: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = secondTextColor
        label.textAlignment = .right
        return label
    }()
    
    lazy var persons: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 0
        label.textColor = secondTextColor
        label.textAlignment = .left
        return label
    }()
    
    lazy var likeButton: UIButton = {
       var button = UIButton()
        let icon = UIImage(systemName: "heart.fill")
        button.setImage(icon, for: .normal)
        button.tintColor = .red
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        return button
    }()
    
    
   fileprivate var pictureView: UIImageView = {
    let image = UIImageView()
    image.contentMode = .scaleAspectFill
    image.alpha = 0.9
    image.clipsToBounds = true
    image.layer.cornerRadius = 16
    image.layer.masksToBounds = true
    return image
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure(recipe: Recipe!){
        minute.text = "\(recipe.readyInMinutes) min"
        persons.text = "\(recipe.servings) people"
        titleLbl.text = (recipe.title)
        likeButton.tag = recipe.id
        pictureView.sd_setImage(with: URL(string: recipe!.image ?? "https://spoonacular.com/recipeImages/716298-556x370.jpg"))
    }
}
