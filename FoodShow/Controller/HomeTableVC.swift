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
    var test: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.request(router: Router.getRandom,id: 0) { (result: [String? : [Recipe]]) in
            self.items = result["recipes"]!
            self.tableView.reloadData()
         }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.recipeNotification),
            name: NSNotification.Name(rawValue: Constants.RECIPE_NOTIFICATION),
            object: nil)
    }
    
    @objc func recipeNotification(notification: Notification){
        if let result = notification.object as? Int {
            
            if let i = items.firstIndex(where: { $0.id == result }) {
                print("before remote recipe id: \(result), remote recipe status: \(items[i].isFav) ")
                guard let userInfo = notification.userInfo else {return}
                guard let isFav = userInfo["status"] as? Int else {return}
                if isFav == 1
                { items[i].isFav = true }
                if isFav == 2
                { items[i].isFav = false }
                
                print("after remote recipe id: \(result), remote recipe status: \(items[i].isFav) ")
                
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
        print(test)
           
       }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        if items.count != 0{
            cell.textLabel?.text = items[indexPath.row].title
        }
        
        

        return cell
    }

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
