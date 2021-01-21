//
//  RecipeCell.swift
//  FoodShow
//
//  Created by Бекболат Азамат on 16.01.2021.
//  Copyright © 2021 TeamOfFour. All rights reserved.
//

import Foundation
import UIKit

protocol TimerDelegate {
    func timeChanged(_ data: Int)

}

class TimerSliderCell: UITableViewCell, ConfigurableCell {
    
    var delegate: TimerDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(timeSlider)
        contentView.backgroundColor = .none
        timeSlider.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview()
        }
        timeSlider.addTarget(self, action: #selector(timerAction),for: .valueChanged)

    }
    
    @objc func timerAction(sender: UISlider!) {
        delegate?.timeChanged(Int(sender.value))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var timeSlider: UISlider = {
        var paybackSlider = UISlider()
            paybackSlider.minimumValue = 0
            paybackSlider.maximumValue = 240
            paybackSlider.isContinuous = true
            paybackSlider.backgroundColor = hexStringToUIColor(hex: "0A202B")
            paybackSlider.tintColor = hexStringToUIColor(hex: "ffb6c1")
        return paybackSlider
    }()
    
    func configure(data: Int) {
        timeSlider.value = Float(data)

    }
}
