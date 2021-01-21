//
//  File.swift
//  FoodShow
//
//  Created by Бекболат Азамат on 21.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import Foundation
import UIKit


class FilterCell: UICollectionViewCell{
   
    override init(frame: CGRect) {
        super.init(frame:frame)
        contentView.addSubview(titleLbl)
        titleLbl.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLbl: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 1
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 16
        return label
    }()
    
    func configure(filterCellMap: (Bool, String)){
        titleLbl.text = (filterCellMap.1.capitalized)
        titleLbl.backgroundColor = !filterCellMap.0 ? .gray : hexStringToUIColor(hex: "ffb6c1")
    }
}
