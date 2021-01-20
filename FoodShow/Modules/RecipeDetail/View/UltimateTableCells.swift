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
    
    lazy var pictureView: UIImageView = {
             let imageView = UIImageView()
             imageView.contentMode = .scaleAspectFill
             imageView.clipsToBounds = true
             imageView.layer.masksToBounds = true
             return imageView
         }()
    
    lazy var animatedView: UIView = {
            let vw = UIView()
            vw.backgroundColor = UIColor.red
           vw.addSubview(pictureView)
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

class ButtonCell: UITableViewCell, ConfigurableCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    private func setUpViews () {
        self.contentView.addSubview(buttonUI)
        buttonUI.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(55)
       }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var buttonUI: UIButton = {
          let button = UIButton()
          button.backgroundColor = .purple
          return button
      }()
    
    func configure(data item: String) {
        self.buttonUI.setTitle(item, for: .normal)
        if item == "Delete from Favorites" {
            self.buttonUI.backgroundColor = .systemRed
        }
        if item == "Add to Favorites" {
            self.buttonUI.backgroundColor = .purple
        }
    }
}

class IngredientsStackView: UITableViewCell, ConfigurableCell {
    
    var servingsCount: Int = 0 {
        didSet{
            servingText.text = "\(servingsCount) servings"
        }
    }
    var twoDoubleFormat = "0.2"
    
    var initialServings: Int?
    
    var ingredients: [ExtendedIngredient]?
    
    let servingText: UILabel = {
              let text = UILabel()
              text.font = .systemFont(ofSize: 20, weight: .heavy)
              text.numberOfLines = 1
              text.textColor = .white
              text.textAlignment = .left
              return text
          }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(ingredientsColumn)
        ingredientsColumn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let ingredientsColumn: UIStackView = {
        var detailStackView: UIStackView = {
            let column          = UIStackView()
            column.axis         = .vertical
            column.distribution = .equalSpacing
            column.spacing      =  16
            return column
        }()
        
     return detailStackView
    }()
    
    func configure(data recipe: Recipe) {
        if recipe.extendedIngredients != nil && ingredientsColumn.subviews.count == 0{
          initialServings = recipe.servings
          ingredients = recipe.extendedIngredients
          servingsCount = recipe.servings ?? 10
          ingredientsColumn.addArrangedSubview(addHeader(servings: recipe.servings ?? 2))
          addLines(items: recipe.extendedIngredients!)
        }
    }
    
    func addHeader(servings: Int) -> UIStackView{
    
        let stepperUI: UIStepper = {
            let myUIStepper = UIStepper (frame:CGRect(x: 10, y: 150, width: 0, height: 0))
            myUIStepper.wraps = true
            myUIStepper.autorepeat = true
            myUIStepper.minimumValue = 1
            myUIStepper.stepValue = 1
            myUIStepper.value = Double(servings)
            myUIStepper.tintColor = .white
            myUIStepper.addTarget(self, action: #selector(self.stepperValueChanged(_:)), for: .valueChanged)
            myUIStepper.setDecrementImage(myUIStepper.decrementImage(for: .normal), for: .normal)
            myUIStepper.setIncrementImage(myUIStepper.incrementImage(for: .normal), for: .normal)
            return myUIStepper
            }()
        
        let labelIconStack: UIStackView = {
            let stackView          = UIStackView()
            stackView.axis         = .horizontal
            stackView.distribution = .equalSpacing
            stackView.spacing      =  4
            return stackView
        }()
        
        labelIconStack.addArrangedSubview(servingText)
        labelIconStack.addArrangedSubview(stepperUI)
        return labelIconStack
    }
    
    @objc func stepperValueChanged(_ sender:UIStepper!){
        servingsCount = Int(sender.value)
        for i in 0 ... ingredientsColumn.arrangedSubviews.count - 1 {
            if(i != 0){
                ((ingredientsColumn.arrangedSubviews[i] as! UIStackView).arrangedSubviews[0] as! UILabel).text = Double((ingredients![i-1].amount * Double(servingsCount))/Double(initialServings!)).format(f:"0.2") + " " + ingredients![i-1].unit
            }
        }
    }
    
    func addLines(items: [ExtendedIngredient]!){
        for ingredient in items{
                          let nameIngredient: UILabel = {
                              let text = UILabel()
                              text.font = .systemFont(ofSize: 16, weight: .medium)
                              text.numberOfLines = 1
                              text.textColor = .white
                              text.textAlignment = .left
                              text.text = ingredient.name
                              return text
                          }()
                   
                          let unitAndCount: UILabel = {
                                         let text = UILabel()
                                         text.font = .systemFont(ofSize: 16, weight: .bold)
                                         text.numberOfLines = 1
                                         text.textColor = .white
                                         text.textAlignment = .left
                            text.text = "\(ingredient.amount.format(f: twoDoubleFormat))" + " " + ingredient.unit
                                         return text
                                     }()
                          
                          let labelIconStack: UIStackView = {
                                      let stackView          = UIStackView()
                                      stackView.axis         = .horizontal
                                      stackView.distribution = .equalSpacing
                                      stackView.spacing      =  4
                                      return stackView
                                  }()
                          labelIconStack.addArrangedSubview(unitAndCount)
                          labelIconStack.addArrangedSubview(nameIngredient)
                          ingredientsColumn.addArrangedSubview(labelIconStack)
                      }
          }
}

class SimilarListCell: UITableViewCell, ConfigurableCell {
    
    var recipesAll: [Recipe]?
    
    var navigationController: UINavigationController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(similarCollectionView)
        similarCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(310)
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
              layout.minimumInteritemSpacing = 24
              layout.minimumLineSpacing = 24
              layout.scrollDirection = .horizontal
              layout.itemSize = CGSize(width: 200, height: 270)
              let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
              cv.backgroundColor = .black
              cv.register(RecipeCell.self, forCellWithReuseIdentifier: "cell")
           return cv
          }()
    
    func configure(data id: Int) {
        if(self.recipesAll == nil){
            NetworkService.request(for: RecipeFind.self, router: Router.getSimilar,id: id, params: [], completion: { [self] (result: RecipeFind) in
                self.recipesAll = result
                self.similarCollectionView.reloadData()
             })

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
        cell.layer.cornerRadius = 12
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        cell.layer.backgroundColor = UIColor.black.cgColor
        cell.layer.masksToBounds = true
        cell.configure(recipe: recipesAll![indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = RecipeDetailViewController(recipe: (recipesAll?[indexPath.row])!)
        self.navigationController?.pushViewController(vc, animated: true)
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
            return "Rating: \(recipe.spoonacularScore ?? 0)%"
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


extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
