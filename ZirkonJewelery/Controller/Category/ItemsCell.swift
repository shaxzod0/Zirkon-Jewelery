//
//  ItemsCell.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit
import Kingfisher

class ItemsCell: BaseCollectionCell<Items>{
    let productImage = UIImageView()
    let productName = UILabel()
    let productDescription = UILabel()
    let priceView = UIView()
    let priceText = UILabel()
    override func initViews(){
        self.addSubview(productImage)
        self.addSubview(productName)
        self.addSubview(productDescription)
        self.addSubview(priceView)
        self.bringSubviewToFront(priceView)
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        productImage.image = UIImage(named: "logo")
        productImage.contentMode = .scaleAspectFit
        productImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        productName.text = "Boss"
        productName.font = .systemFont(ofSize: 25, weight: .bold)
        productName.textAlignment = .center
        productName.snp.makeConstraints { make in
            make.top.equalTo(productImage.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        productDescription.text = "description"
        productDescription.font = .systemFont(ofSize: 14, weight: .light)
        productDescription.textAlignment = .center
        productDescription.numberOfLines = 0
        productDescription.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(10)
            make.right.left.equalToSuperview()
        }
        priceView.applyGradient(isVertical: true, colorArray: [.orangeColor, .purpleColor, .lightBlue])
        priceView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.centerX.equalToSuperview()
        }
        priceView.addSubview(priceText)
        priceText.text = "$500"
        priceText.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
    }
    override func updateUI(with model: Items) {
        let url = URL(string: model.image)
        productImage.kf.setImage(with: url)
        priceText.text = model.price
        productName.text = model.name
        productDescription.text = model.description
    }
}
