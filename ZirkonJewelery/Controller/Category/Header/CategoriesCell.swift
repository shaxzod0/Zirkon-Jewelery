//
//  HeaderCell.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class CategoriesCell: BaseCollectionCell<CategoriesModel> {
   
    let categoryTitle = UILabel()
    
    override func initViews(){
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.addSubview(categoryTitle)
        categoryTitle.text = "Some text"
        categoryTitle.numberOfLines = 0
        categoryTitle.textColor = UIColor(named: "darkBeige")
        categoryTitle.font = .systemFont(ofSize: 25)
        categoryTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    override func updateUI(with model: CategoriesModel) {
        categoryTitle.text = model.categoryName
    }
    
    func setBackground(isSelected: Bool){
        if isSelected {
            categoryTitle.textColor = .white
            self.applyGradient(isVertical: false, colorArray: [.orangeColor, .purpleColor, .lightBlue])
        } else {
            categoryTitle.textColor = .black
            self.applyGradient(isVertical: false, colorArray: [.clear])
        }
    }
}
