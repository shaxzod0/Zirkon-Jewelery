//
//  FavoriteCell.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class FavoriteCell: BaseTableCell<Items> {
    
    let productName = UILabel()
    let productImage = UIImageView()
    
    override func initView(){
        self.addSubview(productName)
        self.addSubview(productImage)
        
        productImage.image = UIImage(named: "sofa")
        productImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.width.height.equalTo(70)
            make.centerY.equalToSuperview()
        }
        
        productName.text = "Sofa"
        productName.numberOfLines = 0
        productName.textColor = .black
        productName.snp.makeConstraints { make in
            make.left.equalTo(productImage.snp.right).offset(20)
            make.centerY.equalToSuperview()
        }
    }
    override func updateUI(with model: Items) {
        productImage.kf.setImage(with: URL(string: model.image))
        productName.text = model.name
    }
}
