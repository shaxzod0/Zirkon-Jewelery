//
//  ItemInformationController.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class ItemInformationController: BaseViewController {
    var viewModel: InfoViewModel
    let productImage = UIImageView()
    let itemBackground = UIView()
    let restView = UIView()
    let secondaryView = UIView()
    let productName = UILabel()
    let aboutLabel = UILabel()
    let productDesc = UILabel()
    let addToCart = UIButton()
    let btnBackView = UIView()
    let priceView = UIView()
    let priceLabel = UILabel()
    let favButton = UIButton()
    init(vm: InfoViewModel) {
        viewModel = vm
        super.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ItemInformationController {
    private func initViews(){
        view.backgroundColor = .backColor
        view.addSubview(restView)
        restView.backgroundColor = .backColor
        restView.layer.cornerRadius = 70
        restView.clipsToBounds = true
        restView.layer.masksToBounds = true
        restView.layer.maskedCorners = [.layerMinXMinYCorner]
        restView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.6)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        view.addSubview(itemBackground)
        itemBackground.backgroundColor = .white
        itemBackground.layer.cornerRadius = 70
        itemBackground.clipsToBounds = true
        itemBackground.layer.masksToBounds = true
        itemBackground.layer.maskedCorners = [.layerMaxXMaxYCorner]
        itemBackground.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalToSuperview()
            make.centerX.equalToSuperview()
            make.left.right.top.equalToSuperview()
        }
        view.addSubview(secondaryView)
        secondaryView.backgroundColor = .white
        view.sendSubviewToBack(secondaryView)
        secondaryView.snp.makeConstraints { make in
            make.height.equalToSuperview().multipliedBy(0.6)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }
        itemBackground.addSubview(productImage)
        productImage.contentMode = .scaleAspectFit
        productImage.snp.makeConstraints { make in
            make.width.height.equalToSuperview().multipliedBy(0.8)
            make.centerY.centerX.equalToSuperview()
        }
        restView.addSubview(productName)
        restView.addSubview(productDesc)
        restView.addSubview(aboutLabel)
        productName.font = .systemFont(ofSize: 30, weight: .bold)
        productName.textAlignment = .center
        productName.textColor = UIColor(named: "darkBeige")
        productName.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        aboutLabel.text = "About"
        aboutLabel.textAlignment = .left
        aboutLabel.textColor = UIColor(named: "darkBeige")
        aboutLabel.font = .systemFont(ofSize: 20, weight: .bold)
        aboutLabel.snp.makeConstraints { make in
            make.top.equalTo(productName.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
        }
        productDesc.numberOfLines = 0
        productDesc.font = .systemFont(ofSize: 25, weight: .light)
        productDesc.textColor = UIColor(named: "darkBeige")
        productDesc.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.top.equalTo(aboutLabel.snp.bottom).offset(30)
        }
        view.addSubview(btnBackView)
        btnBackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.bottom.equalToSuperview().offset(-20)
        }
        view.layoutSubviews()
        view.layoutIfNeeded()
        btnBackView.layer.cornerRadius = 15
        btnBackView.applyGradient(isVertical: false, colorArray: [.orangeColor, .purpleColor, .lightBlue])
        btnBackView.addSubview(addToCart)
        btnBackView.layer.masksToBounds = true
        restView.bringSubviewToFront(btnBackView)
        restView.addSubview(priceView)
        restView.bringSubviewToFront(priceView)
        priceView.backgroundColor = UIColor(named: "darkBeige")
        priceView.layer.cornerRadius = 15
        priceView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(50)
            make.bottom.equalTo(btnBackView.snp.top).offset(-20)
        }
        priceView.addSubview(priceLabel)
        priceLabel.textColor = .white
        priceLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        addToCart.layer.cornerRadius = 15
        addToCart.addTarget(self, action: #selector(saveButton), for: .touchUpInside)
        addToCart.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        itemBackground.addSubview(favButton)
        itemBackground.bringSubviewToFront(favButton)
        favButton.addTarget(self, action: #selector(favBtn), for: .touchUpInside)
        favButton.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalToSuperview()
            make.height.width.equalTo(100)
        }
        updateUI()
    }
    func updateUI() {
        guard let data = viewModel.getItem() else { return }
        let url = URL(string: data.image)
        productImage.kf.setImage(with: url)
        productName.text = data.name
        productDesc.text = data.description
        priceLabel.text = data.price
        addToCart.setTitle(viewModel.isInCart(), for: .normal)
        if viewModel.isFavorite() {
            favButton.setImage(UIImage(named: "favUns")?.withRenderingMode(.alwaysOriginal).withTintColor(.red), for: .normal)
        }else{
            favButton.setImage(UIImage(named: "favUns")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray), for: .normal)
        }
    }
    @objc func favBtn() {
        viewModel.manageFav()
        if viewModel.isFavorite() {
            favButton.setImage(UIImage(named: "favUns")?.withRenderingMode(.alwaysOriginal).withTintColor(.red), for: .normal)
        } else {
            favButton.setImage(UIImage(named: "favUns")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray), for: .normal)
        }
    }
    @objc func saveButton() {
        viewModel.manageCart()
        addToCart.setTitle(viewModel.isInCart(), for: .normal)
    }
}
