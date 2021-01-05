//
//  UltimateTableCells.swift
//  FoodShow
//
//  Created by AzaDev on 1/2/21.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import UIKit
import SDWebImageSVGCoder

class MessageCell: UITableViewCell, ConfigurableCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         setUpViews()
     }
    
    private func setUpViews () {
        self.contentView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 0
        return lbl
    }()
    
    func configure(data message: String) {
        messageLabel.text = message
    }
}

class AnimatedHeader: UIView {
    
    lazy var titleLbl: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 28, weight: .bold)
            label.numberOfLines = 0
            label.textColor = .white
            label.textAlignment = .center
            return label
        }()
    
    var recipe: Recipe!

    init(recipe:Recipe){
        super.init(frame:.zero)
         self.recipe = recipe
        self.addSubview(animatedView)
        animatedView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     
      
       lazy var overlayView: UIView = {
          let overlayView = UIView()
          overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
          return overlayView
      }()
    
    fileprivate lazy var gradientImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.image = UIImage(named: "fog")
           return imageView
       }()
    
    lazy var animatedView: UIView = {
            let vw = UIView()
            vw.backgroundColor = UIColor.red
            let pictureView: UIImageView = {
                     let imageView = UIImageView()
                     imageView.contentMode = .scaleAspectFill
                     imageView.clipsToBounds = true
                     imageView.layer.masksToBounds = true
                     return imageView
                 }()
           vw.addSubview(pictureView)
           vw.addSubview(gradientImageView)
           vw.addSubview(overlayView)
           vw.addSubview(titleLbl)
           
           overlayView.snp.makeConstraints { (make) in
               make.edges.equalToSuperview()
           }
           titleLbl.text = self.recipe.title
           titleLbl.snp.makeConstraints { (make) in
               make.bottom.equalToSuperview().offset(-16)
               make.leading.trailing.equalToSuperview().inset(40)
           }
            pictureView.sd_setImage(with: URL(string: recipe.image ?? ""))
            pictureView.snp.makeConstraints { (make) in
                       make.bottom.leading.trailing.equalToSuperview()
                       make.height.equalToSuperview()
                   }
            vw.backgroundColor = .black
            return vw
    }()
    
    
}



class ImageCell: UITableViewCell, ConfigurableCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    private func setUpViews () {
        self.contentView.addSubview(pictureView)
        pictureView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(256)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var pictureView: UIImageView = {
          let image = UIImageView()
          return image
      }()
    
    func configure(data url: URL?) {
         self.pictureView.sd_setImage(with: url)
    }
}

class StepCell: UITableViewCell, ConfigurableCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    private func setUpViews () {
        self.contentView.addSubview(labelStep)
        labelStep.snp.makeConstraints { (make) in
                   make.edges.equalToSuperview()
               }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var labelStep: UILabel = {
          let stepText = UILabel()
          stepText.font = .systemFont(ofSize: 18, weight: .medium)
          stepText.numberOfLines = 0
          stepText.textColor = .white
          stepText.textAlignment = .left
          return stepText
      }()
    
    func configure(data instructuon: Step?) {
        self.labelStep.text = instructuon?.step
    }
}

