//
//  HomeVC.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 26.12.2020.
//  Copyright © 2020 TeamOfFour. All rights reserved.
//

import UIKit

class HomeTableVC: UITableViewController {
    

       let networkService = NetworkService()
       var collectionTitleString: String = ""
       var items: [Recipe] = []
       var recipes: [Recipe] = []
       var test: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.request(router: Router.getRandom,id: 0) { (result: [String? : [Recipe]]) in
            self.items = result["recipes"]!
            self.tableView.reloadData()

         }
        checkFavorites(item: items)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.recipeNotification),
            name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
            object: nil)
    }
  
    
    func checkFavorites(item: [Recipe]){
        let RL = RecipeLocalService()
        recipes = RL.extractRecipes()
        print(recipes.count)
    }
    
    @objc func recipeNotification(notification: Notification){
        if let result = notification.object as? Recipe {
            if let i = items.firstIndex(where: { $0.id == result.id }) {
                items[i].isFav = result.isFav
                self.tableView.reloadData()
            }
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RecipeDetailViewController(recipe: items[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)           
       }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        if items.count != 0{
            cell.textLabel?.text = items[indexPath.row].title
        }
        return cell
    }
}
