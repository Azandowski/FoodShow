//
//  HomeVC.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 26.12.2020.
//  Copyright © 2020 TeamOfFour. All rights reserved.
//

import UIKit

class HomeVC: UITableViewController {
    

       let networkService = NetworkService()
       var collectionTitleString: String = ""
       var items: [Recipe] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Закоментировал пока запросы в сеть чтобы не исчерпать запросы
        
//        NetworkService.request(router: Router.getRandom) { (result: [String : [Recipe]]) in
//            self.items = result["recipes"]!
//            print(self.items.last?.id ??  "привет")
//        }
//
        
        let RL = RecipeLocalService()
        
     // удаление по id рецепта
    //    RL.removeRecipes(with: 715477)
        
    // получение рецептов из базы локальной
        
        RL.getAllRecipe(completion: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let recipe):
                print(recipe)
            }
            //проверял сколько объектов в базе, можно будет удалить после проверки
            print(try! result.get().count)
            
        })
        // конвертирование структуры в объект реалма
        //let newReandomRecipe = RL.convertToRecipeLocalObject(with: self.items)
        
        //сохранение массива объектов локально в реалм
        //RL.saveRecipe(with: newReandomRecipe)
        //print(newReandomRecipe)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
