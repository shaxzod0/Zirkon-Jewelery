//
//  CartCell.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 18/05/22.
//

import UIKit

class CartCell: BaseCollectionCell<Items> {
    let productImage = UIImageView()
    let productName = UILabel()
    let productDesc = UILabel()
    let productPrice = UILabel()
    let productCount = UILabel()
    var index: Int = 1
    let increaseBtn = UIButton()
    let decreaseBtn = UIButton()
    let cancelBtn = UIButton()
    override func initViews(){
        self.addSubview(productImage)
        self.addSubview(productName)
        self.addSubview(productDesc)
        self.addSubview(productPrice)
        self.addSubview(productCount)
        self.addSubview(increaseBtn)
        self.addSubview(decreaseBtn)
        self.addSubview(cancelBtn)
        productImage.image = UIImage(named: "sofa")
        productImage.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(150)
            make.centerY.equalToSuperview()
        }
        productName.text = "Pink Diamond"
        productName.numberOfLines = 0
        productName.textColor = UIColor(named: "darkBeige")
        productName.font = .systemFont(ofSize: 20, weight: .bold)
        productName.snp.makeConstraints { make in
            make.left.equalTo(productImage.snp.right).inset(10)
            make.top.equalTo(productImage.snp.top)
            make.right.equalToSuperview()
        }
        productDesc.text = "Round Cut Cubic Zircon Stones."
        productDesc.numberOfLines = 2
        productDesc.textColor = .textColor
        productDesc.font = .systemFont(ofSize: 16, weight: .heavy)
        productDesc.snp.makeConstraints { make in
            make.left.equalTo(productImage.snp.right).inset(10)
            make.top.equalTo(productName.snp.bottom).offset(5)
            make.right.equalToSuperview().inset(20)
        }
        productPrice.text = "$600"
        productPrice.backgroundColor = .lightBlue
        productPrice.layer.cornerRadius = 15
        productPrice.textAlignment = .center
        productPrice.layer.masksToBounds = true
        productPrice.textColor = UIColor(named: "darkBeige")
        productPrice.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(productDesc.snp.bottom).offset(10)
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(55)
        }
        
        decreaseBtn.layer.cornerRadius = 25 / 2
        decreaseBtn.clipsToBounds = true
        decreaseBtn.backgroundColor = .lightBlue.withAlphaComponent(0.5)
        decreaseBtn.setTitle("-", for: .normal)
        decreaseBtn.setTitleColor(.black, for: .normal)
        decreaseBtn.addTarget(self, action: #selector(decreaseIndex), for: .touchUpInside)
        decreaseBtn.snp.makeConstraints { make in
            make.left.equalTo(productImage.snp.right).inset(10)
            make.centerY.equalTo(productPrice.snp.centerY)
            make.width.height.equalTo(25)
        }
        productCount.text = "\(index)"
        productCount.textColor = .black
        productCount.snp.makeConstraints { make in
            make.left.equalTo(decreaseBtn.snp.right).inset(-10)
            make.centerY.equalTo(decreaseBtn.snp.centerY)
        }
        increaseBtn.layer.cornerRadius = 25 / 2
        increaseBtn.clipsToBounds = true
        increaseBtn.addTarget(self, action: #selector(increaseIndex), for: .touchUpInside)
        increaseBtn.backgroundColor = .lightBlue.withAlphaComponent(0.5)
        increaseBtn.setTitle("+", for: .normal)
        increaseBtn.setTitleColor(.black, for: .normal)
        increaseBtn.snp.makeConstraints { make in
            make.left.equalTo(productCount.snp.right).inset(-10)
            make.centerY.equalTo(productPrice.snp.centerY)
            make.width.height.equalTo(25)
        }
        cancelBtn.setImage(UIImage(named: "cancel"), for: .normal)
        cancelBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(-20)
        }
    }
    
    override func updateUI(with model: Items) {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        productName.text = model.name
        productDesc.text = model.description
        productPrice.text = model.price
        let url = URL(string: model.image)
        productImage.kf.setImage(with: url)
    }
    
    @objc func increaseIndex(){
        index += 1
    }
    @objc func decreaseIndex(){
        index -= 1
        if index == 0 {
            index = 1
        }else{
            index -= 1
        }
    }
}
