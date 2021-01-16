//
//  RecipeDetailVC.swift
//  FoodShow
//
//  Created by AzaDev on 1/2/21.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SDWebImageSVGCoder

class RecipeDetailViewController: UIViewController {
  
    var recipe: Recipe!
    var recipeId: Int = 0

     init(recipe:Recipe){
        super.init(nibName: nil, bundle: nil)
        self.recipe = recipe
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    lazy var viewModel:TableViewModel={
        var viewModel = TableViewModel()
        return viewModel
    }()
    
   lazy var animatedHeader = AnimatedHeader(recipe: recipe)
    
   lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: self.view.frame.height * 0.4, left: 0, bottom: 0, right: 0)
        tableView.register(MessageCell.self, forCellReuseIdentifier:String(describing: MessageCell.self))
        tableView.register(ImageCell.self, forCellReuseIdentifier:String(describing: ImageCell.self))
        tableView.register(StepCell.self, forCellReuseIdentifier:String(describing: StepCell.self))
        tableView.register(DetailStackView.self, forCellReuseIdentifier:String(describing: DetailStackView.self))
        tableView.register(SimilarListCell.self, forCellReuseIdentifier:String(describing: SimilarListCell.self))
        tableView.register(ButtonCell.self, forCellReuseIdentifier:String(describing: ButtonCell.self))
        tableView.register(IngredientsStackView.self, forCellReuseIdentifier:String(describing: IngredientsStackView.self))
        tableView.backgroundView?.backgroundColor = .black
        tableView.backgroundColor = .black
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = false
       }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        self.view.addSubview(tableView)
        self.view.addSubview(animatedHeader)
        self.view.backgroundColor = .black
        tableView.snp.makeConstraints { (make) in make.edges.equalToSuperview() }
        animatedHeader.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: self.view.frame.height * 0.4)
        
        NotificationCenter.default.addObserver(
                   self,
                   selector: #selector(self.recipeNotification),
                   name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
                   object: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = -scrollView.contentOffset.y
        if (y >= 40) {
            let minHeight: CGFloat = 80.0
            let currentHeight = max(minHeight, y)
            self.animatedHeader.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: currentHeight)
            self.animatedHeader.overlayView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1 - (abs(y) * 1 / (view.frame.height * 0.8)))
                self.animatedHeader.titleLbl.text = recipe.title
                self.animatedHeader.titleLbl.numberOfLines = 0
                self.animatedHeader.titleLbl.font = .systemFont(ofSize: 26, weight: .bold)
        } else {
            self.animatedHeader.titleLbl.numberOfLines = 1
            self.animatedHeader.titleLbl.font = .systemFont(ofSize: 22, weight: .bold)
        }
    }
    
    @objc func recipeNotification(notification: Notification){
           if let result = notification.object as? Recipe {
               print(result.isFav)
               recipe.isFav = result.isFav
               viewModel.updateItems(recipe: result)
               tableView.reloadData()
           }
           
       }
    
    @objc func buttonAction(sender: UIButton!) {
            
            let RL = RecipeLocalService()
            if self.recipe.isFav == false {
                    let favItems: [Recipe] = [self.recipe]
                    let newFavRecipe = RL.convertToRecipeLocalObject(with: favItems)
                    RL.saveRecipe(with: newFavRecipe)
                    self.recipe.isFav = true
                    viewModel.updateItems(recipe: self.recipe)
                    tableView.reloadData()
            } else{
                RL.removeRecipes(with: recipe.id)
                    self.recipe.isFav = false
                    viewModel.updateItems(recipe: self.recipe)
                    tableView.reloadData()

                  }
            
                NotificationCenter.default.post(
                    name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
                    object: self.recipe )
        }
    }



    extension RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.updateItems(recipe: recipe).count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.updateItems(recipe: recipe)[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
        
        cell.backgroundColor = .black
      
        item.configure(cell: cell)
        
        if  viewModel.updateItems(recipe: recipe)[indexPath.section] is ButtonCellConfig{
            (cell as! ButtonCell).buttonUI.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        }
        return cell
    }
 
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
         let headerStep: UILabel = {
                       let stepText = UILabel()
                       stepText.font = .systemFont(ofSize: 24, weight: .bold)
                       stepText.numberOfLines = 1
                       stepText.textColor = .white
                       stepText.textAlignment = .left
                      return stepText
                   }()
        
            if viewModel.updateItems(recipe: recipe)[section] is StepCellConfig {
                
                headerStep.text =  "Step: \(section-3 + 1)/\(recipe.analyzedInstructions![0].steps.count)"
                return headerStep
                
               }else if viewModel.updateItems(recipe: recipe)[section] is SimilarListConfig {
                
                headerStep.text =  "Similar Recipies"
                return headerStep
                
               } else if viewModel.updateItems(recipe: recipe)[section] is IngredientsCellConfig {
                
                headerStep.text =  "Ingredients"
                return headerStep
                
               }else{
                return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
    }
    
}

