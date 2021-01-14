//
//  HomeVC.swift
//  FoodShow
//
//  Created by Aigerim Ilipova on 26.12.2020.
//  Copyright © 2020 TeamOfFour. All rights reserved.
//

import UIKit

class HomeTableVC: UITableViewController {
    
    
    let items: [Recipe] = [
        Recipe(title: "Блюдо 1"),
        Recipe(title: "Блюдо 2"),
        Recipe(title: "Блюдо 3"),
        Recipe(title: "Блюдо 4"),
        Recipe(title: "Блюдо 5"),
        Recipe(title: "Блюдо 6"),
        Recipe(title: "Блюдо 7"),
        Recipe(title: "Блюдо 8"),
        Recipe(title: "Блюдо 9"),
        Recipe(title: "Блюдо 10")
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 3
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let index = indexPath.row + 3
        
//        if items.count != 0{
//            cell.textLabel?.text = items[indexPath.row].title
//        }
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Delicious food for you"
            print(index)
            
        case 1:
            
            let searchTextField = UITextField()
            let filterButton = UIButton(type: .custom)
            searchTextField.attributedPlaceholder = NSAttributedString(string: "Search")
            filterButton.setTitle("", for: .normal)
            filterButton.setBackgroundImage( UIImage(named: "search"), for: .normal)
            
            print(index)
            
        case 3:
            
            print(index)
            cell.textLabel?.text = "Delicious food for you"
            
        default:
            print(index)
//            cell.textLabel?.text = items[index].title
        }
        

        return cell
    }


}
