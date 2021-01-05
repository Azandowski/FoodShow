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

class SimilarListCell: UITableViewCell, ConfigurableCell {
    
    var recipesAll: [Recipe]?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(similarCollectionView)
        similarCollectionView.snp.makeConstraints { (make) in
            make.height.equalTo(100)
            make.width.equalToSuperview()
        }

        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let similarCollectionView: UICollectionView = {
              let layout = UICollectionViewFlowLayout()
              layout.scrollDirection = .horizontal
              let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
              cv.backgroundColor = .black
              cv.register(RecipeCell.self, forCellWithReuseIdentifier: "cell")
           return cv
          }()
    
    func configure(data id: Int) {
        if(self.recipesAll == nil){
            NetworkService.request(router: Router.getSimilar, id: id) { (result: [String? : [Recipe]]) in
                self.recipesAll = result["recipies"]!
                self.similarCollectionView.reloadData()
            }
        }
    }
}

extension SimilarListCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if recipesAll != nil{
           return recipesAll!.count
         }else{
            return 0
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! RecipeCell
        cell.recipe = recipesAll![indexPath.row]
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
}

class RecipeCell: UICollectionViewCell{
    
    var recipe: Recipe!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentView.addSubview(pictureView)
        pictureView.snp.makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(100)
        }
    }
    
   fileprivate var pictureView: UIImageView = {
    let image = UIImageView()
    image.translatesAutoresizingMaskIntoConstraints = false
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.layer.cornerRadius = 12
    image.sd_setImage(with: URL(string: "https://spoonacular.com/recipeImages/659782-556x370.jpg"))
        return image
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DetailStackView: UITableViewCell, ConfigurableCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    private func setUpViews () {
        self.contentView.addSubview(detailStackView)
        detailStackView.snp.makeConstraints { (make) in
                   make.edges.equalToSuperview()
               }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var detailStackView: UIStackView = {
          let stackView          = UIStackView()
          stackView.axis         = .horizontal
          stackView.distribution = .fillEqually
          stackView.spacing      =  16
          return stackView
      }()
    
    func configure(data recipe: Recipe) {
        if detailStackView.subviews.count < 3 {
          addDetailViews(recipe: recipe)
        }
    }
    
    func addDetailViews(recipe: Recipe){
        
        for i in 1...3{
            
            let detailText: UILabel = {
                let text = UILabel()
                text.font = .systemFont(ofSize: 18, weight: .medium)
                text.numberOfLines = 1
                text.textColor = .white
                text.textAlignment = .center
                return text
            }()
            
            let iconView: UIImageView = {
                let image = UIImageView()
                image.contentMode = .scaleAspectFit
                image.tintColor = .white
                return image
            }()
            
            let labelIconStack: UIStackView = {
                        let stackView          = UIStackView()
                        stackView.axis         = .vertical
                        stackView.distribution = .equalCentering
                        stackView.spacing      =  16
                        return stackView
                    }()
            
            detailText.text = returnNeedText(recipe: recipe,id: i)
            let paperPlane = UIImage(systemName: returnIconName(id: i))
            paperPlane?.withTintColor(.white)
            iconView.image = paperPlane
            iconView.snp.makeConstraints { (make) in
                make.height.equalTo(40)
            }
            labelIconStack.addArrangedSubview(iconView)
            labelIconStack.addArrangedSubview(detailText)
            detailStackView.addArrangedSubview(labelIconStack)
        }
    }
    
    func returnNeedText(recipe:Recipe, id: Int)->String{
        switch id {
        case 1:
            return "Persons: \(recipe.servings)"
        case 2:
            return "\(recipe.readyInMinutes) minutes"
        default:
            return "Rating: \(recipe.spoonacularScore)%"
        }
    }
    
    func returnIconName(id: Int)->String{
        switch id {
        case 1:
            return "person.circle.fill"
        case 2:
            return "clock.fill"
        default:
            return "star.circle.fill"
        }
    }

}


