//
//  FiltterCollectionView.swift
//  FoodShow
//
//  Created by Бекболат Азамат on 21.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import UIKit
import SDWebImageSVGCoder

protocol FilterDelegate {
    func filterCellTapped(_ data: (type: String, name: String))
}

class FilterList: UITableViewCell, ConfigurableCell {
        
    var delegate: FilterDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(similarCollectionView)
        similarCollectionView.backgroundColor = hexStringToUIColor(hex: "0A202B")
        similarCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview()
        }

        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var needTypes: [String]?
    
    var needTypeName: String?
    
    var filter: Filter?

    fileprivate let similarCollectionView: UICollectionView = {
              let layout = UICollectionViewFlowLayout()
              layout.minimumInteritemSpacing = 12
              layout.minimumLineSpacing = 12
              layout.scrollDirection = .horizontal
              layout.itemSize = CGSize(width: 120, height: 40)
              let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
              cv.showsHorizontalScrollIndicator = false
              cv.register(FilterCell.self, forCellWithReuseIdentifier: "filterCell")
           return cv
          }()
    
    func configure(data: (String,Filter)) {
        needTypes = returnNeedList(tag: data.0, filter: data.1)
        needTypeName = data.0
        filter = data.1
        similarCollectionView.reloadData()
    }
    
    func returnNeedList(tag: String, filter: Filter) -> [String]{
        switch tag {
        case "cuisine":
            return filter.cuisinesList
        case "type":
            return filter.typeList
        case "diet":
            return filter.dietList
        case "intolerances":
            return filter.intoleranceList
        default:
            return []
        }
    }
    
    func returnNeedActiveList(tag: String, filter: Filter) -> [String]{
        switch tag {
        case "cuisine":
            return filter.activeCuisinesList
        case "type":
            return filter.activeTypeList
        case "diet":
            return filter.activeDietList
        case "intolerances":
            return filter.activeIntoleranceList
        default:
            return []
        }
    }
    
}

extension FilterList: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if needTypes != nil{
           return needTypes!.count
         }else{
            return 0
         }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCell
        cell.layer.cornerRadius = 8
        cell.configure(filterCellMap: (returnNeedActiveList(tag: needTypeName!, filter: filter!).contains(needTypes![indexPath.row]), needTypes![indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout) -> CGSize {
        return CGSize(width: 120, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.filterCellTapped( (needTypeName!, needTypes![indexPath.row]))
        similarCollectionView.reloadData()
    }

}
