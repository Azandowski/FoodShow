//
//  FilterViewController.swift
//  FoodShow
//
//  Created by Бекболат Азамат on 21.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol FilterApplyDelegate {
    func filterApplied(filter: Filter)
}

class FilterViewController: UIViewController, FilterDelegate, TimerDelegate {
    
    var delegate: FilterApplyDelegate?
    
    func timeChanged(_ data: Int) {
        filter.maxTime = data
        tableView.reloadData()
    }
    
    @objc func applyAction(sender: UIButton!) {
        delegate?.filterApplied(filter: self.filter)
        self.dismiss(animated: true, completion: nil)

    }
    
    func filterCellTapped(_ data: (type: String, name: String)) {
        switch data.type {
        case "cuisine":
            filter.activeCuisinesList = reorderData(tags: filter.activeCuisinesList, name: data.name)
        case "type":
            filter.activeTypeList = reorderData(tags: filter.activeTypeList, name: data.name)
        case "diet":
            filter.activeDietList = reorderData(tags: filter.activeDietList, name: data.name)
        case "intolerances":
            filter.activeIntoleranceList = reorderData(tags: filter.activeIntoleranceList, name: data.name)
        default: break
            
        }
        tableView.reloadData()
    }
    
   func reorderData(tags:[String],name:String)->[String]{
    var items = tags
        if items.contains(name) {
            if let index = items.firstIndex(of: name) {
                items.remove(at: index)
            }
        }else{
            items.append(name)
        }
    return items
    }
    
   
    var filter: Filter!
    
    init(filter:Filter){
       super.init(nibName: nil, bundle: nil)
       self.filter = filter
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var viewModel:FilterTableViewModel={
        var viewModel = FilterTableViewModel()
        return viewModel
    }()
    
    let headingList = ["Cuisine","Type","Diet","Intolerances"]

   lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tableView.register(TimerSliderCell.self, forCellReuseIdentifier:String(describing: TimerSliderCell.self))
        tableView.register(FilterList.self, forCellReuseIdentifier:String(describing: FilterList.self))
        tableView.register(DoneButtonCell.self, forCellReuseIdentifier:String(describing: DoneButtonCell.self))
        tableView.backgroundView?.backgroundColor = backroundColor
        tableView.backgroundColor = backroundColor
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = false
       }
    let backroundColor = hexStringToUIColor(hex: "0A202B")

    override func viewDidLoad() {
    super.viewDidLoad()
        self.view.addSubview(tableView)
        self.view.backgroundColor = backroundColor
        tableView.snp.makeConstraints { (make) in make.edges.equalToSuperview() }
    }
    
}

    extension FilterViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getFilterItems(filter: self.filter).count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.getFilterItems(filter: self.filter)[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
        
        cell.backgroundColor = .none
        
        item.configure(cell: cell)
        
        if (cell is FilterList) {
            (cell as! FilterList).delegate = self
        }else if (cell is TimerSliderCell){
            (cell as! TimerSliderCell).delegate = self
        }
        
        if (cell is DoneButtonCell){
            (cell as! DoneButtonCell).buttonUI.addTarget(self, action: #selector(applyAction), for: .touchUpInside)
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

            if viewModel.getFilterItems(filter: filter)[section] is FilterListConfig {

                headerStep.text =  headingList[section]
                return headerStep
                
               } else if viewModel.getFilterItems(filter: filter)[section] is TimerCellConfig{
                headerStep.text =  "Maximum Time: \(filter.maxTime) min"
                return headerStep
               }else{
                return nil
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
    }
    
}


