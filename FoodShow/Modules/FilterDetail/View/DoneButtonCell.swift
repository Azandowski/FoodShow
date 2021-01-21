//
//  DoneButtonCell.swift
//  FoodShow
//
//  Created by Бекболат Азамат on 21.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//
import Foundation
import UIKit

class DoneButtonCell: UITableViewCell, ConfigurableCell {
    
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
           button.tintColor = .white
          return button
      }()
    
    func configure(data item: String) {
        self.buttonUI.setTitle(item, for: .normal)
        self.buttonUI.backgroundColor = hexStringToUIColor(hex: "ffb6c1")
        
    }
}
