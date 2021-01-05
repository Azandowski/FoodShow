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

     init(recipe:Recipe){
        super.init(nibName: nil, bundle: nil)
        self.recipe = recipe
    }
    
    var maxHeight : CGFloat = 256.0
    var minHeight : CGFloat = 0.0
    var previousScrollingOffsetValue : CGFloat = 0.0
    var heightConstraint: Constraint?
    var height: CGFloat = 256

    
    var isOpenButton = 0
    var topViewSize:CGFloat = 318 // Topview height
    var navigationHeight:CGFloat = 82 // Headerview height
    var statusHeight = UIApplication.shared.statusBarFrame.size.height//Statusbar height

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    lazy var viewModel:TableViewModel={
        var viewModel = TableViewModel(recipe: self.recipe)
        return viewModel
    }()
    
   lazy var animatedHeader = AnimatedHeader(recipe: recipe)
    
   lazy var tableView: UITableView = {
    
        let tableView = UITableView()
        tableView.delegate = self
        tableView.separatorStyle = .none
    tableView.contentInset = UIEdgeInsets(top: topViewSize, left: 0, bottom: 0, right: 0)
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = animatedHeader
        tableView.register(MessageCell.self, forCellReuseIdentifier:String(describing: MessageCell.self))
        tableView.register(ImageCell.self, forCellReuseIdentifier:String(describing: ImageCell.self))
        
        return tableView
    }()
    
    lazy var topView = AnimatedHeader(recipe: recipe)

    override func viewDidLoad() {
    super.viewDidLoad()
        
        let view = Bundle.main.loadNibNamed("TopView", owner: self, options: nil)![0] as! AnimatedHeader
        view.frame = CGRect(x: 0, y: statusHeight, width: self.view.frame.width, height: self.view.frame.width)
        self.view.addSubview(view)
        topView = view
        tableView.estimatedRowHeight = 50
        tableView.contentInset = UIEdgeInsets(top: topViewSize, left: 0, bottom: 0, right: 0)
        
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in make.edges.equalToSuperview() }
        animatedHeader.snp.makeConstraints{(make) in
        make.top.bottom.leading.trailing.equalToSuperview()
        make.width.equalTo(tableView)
        make.height.equalTo(256)
        self.heightConstraint = make.height.equalTo(256).constraint
        }
        animatedHeader.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        height = 256
        maxHeight = height
        minHeight = 0.0
      }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        let y = topViewSize - (scrollView.contentOffset.y + topViewSize)
        let newHeaderViewHeight = topView.frame.height - scrollView.contentOffset.y
        
        if(y >= navigationHeight){
            if(y<=148 && y >= navigationHeight){
                let percent:Float = (Float((148-y) / y));
                topView.albumTopButton.alpha = CGFloat(percent)
            }else{
                topView.albumTopButton.alpha = 0
            }
            
            topView.albumTopButton.frame.origin.y = y
            
            if(isOpenButton == 1){
                isOpenButton = 0
                UIView.animate(withDuration: 0.1, animations: {
                    self.topView.btnAlbum.frame.origin.x = self.topView.btnAlbum.frame.origin.x + 5
                    self.topView.btnMusic.frame.origin.x = self.topView.btnMusic.frame.origin.x - 5
                }) { (Bool) in
                    self.shakeAnimation()
                }
            }
        }else{
            if(isOpenButton == 0){
                isOpenButton = 1
                UIView.animate(withDuration: 0.1, animations: {
                    self.topView.btnAlbum.frame.origin.x = self.topView.btnAlbum.frame.origin.x - 5
                    self.topView.btnMusic.frame.origin.x = self.topView.btnMusic.frame.origin.x + 5
                }) { (Bool) in
                    self.shakeAnimation()
                }
            }
            topView.albumTopButton.alpha = 1
            topView.albumTopButton.frame.origin.y = 100
        }
        
        let height = min(max(y, navigationHeight), 800)
        topView.frame = CGRect(x: 0, y: statusHeight, width: UIScreen.main.bounds.size.width, height: height)
        
        if(y >= topViewSize){
            topView.albumimage.transform = CGAffineTransform(scaleX: (y/topViewSize), y: (y/topViewSize))
            topView.albumTop.constant = 25
        }else{
            topView.albumTop.constant = (y-(topViewSize-25))+((y-topViewSize)*0.6)
        }
        
        if(y >= topViewSize){
            let final = ((450)-y) / ((450) - topViewSize)
            topView.albumButton.alpha = CGFloat(final)
        }else if (newHeaderViewHeight > topViewSize){
            let alphavalue = (newHeaderViewHeight/topViewSize) - 1
            topView.albumButton.alpha = CGFloat(alphavalue)
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            self.heightConstraint!.deactivate()
//              // get difference offset value between current scrollview y axis and previsously scrolled offset
//              let difference = scrollView.contentOffset.y - previousScrollingOffsetValue
//              // Check weather maxHeight is greater than headerViewHeightConstraint and then assign maxHeight to headerViewHeightConstraint
//
//              if self.height > maxHeight {
//                  self.height = maxHeight
//              } else {
//                  //Else eliminate difference offset value from  headerViewHeightConstraint constant value and assign to headerViewHeightConstraint constant value
//                  self.height = self.height - difference //Else eliminate difference offset value from  headerViewHeightConstraint constant value and assign to headerViewHeightConstraint constant value
//              }
//              previousScrollingOffsetValue = scrollView.contentOffset.y // Reset difference variable with current scrollView y-axis offset
//            self.animatedHeader.snp.makeConstraints{ (make) in
//            self.heightConstraint = make.height.equalTo(self.height).constraint
//
//            }
//          }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//            self.heightConstraint!.deactivate()
//
//            let  midValue =  self.maxHeight / 2  // half range value of maxheight
//            UIView.animate(withDuration: 0.2) {
//                // if current height of headeview is greated than mid value. Set minHeight as a height of  headerview else Set maxHeight as a height of  headerview
//                if midValue > self.height {
//                    self.height = self.minHeight
//                    print("min")
//                } else {
//                    print("max")
//                    self.height = 256
//                }
//                self.animatedHeader.snp.makeConstraints{ (make) in
//                    self.heightConstraint = make.height.equalTo(self.height).constraint
//                }
//                self.view.layoutIfNeeded()
//            }
//
//        }
    
}

extension RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId)!
        item.configure(cell: cell)

        return cell
    }
    
}

