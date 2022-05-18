//
//  CartController.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class CartController: BaseViewController {

    let cartViewModel = CartViewModel()
    weak var collectionView: UICollectionView?
    let totalPrice = UILabel()
    let orderButton = UIButton()
    let buttonBackground = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.navigationBar.topItem!.title = "Cart"
        cartViewModel.fetchProducts()
        if cartViewModel.isProductsEmpty(){
            isLoading = true
        }else {
            isLoading = false
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        buttonBackground.applyGradient(isVertical: false, colorArray: [.orangeColor, .purpleColor, .lightBlue])
        totalPrice.text = "Total: \(cartViewModel.getTotalPrice())"
    }
}

extension CartController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    private func initViews(){
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .vertical
        l.minimumInteritemSpacing = 10
        l.minimumLineSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: l)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.reloadData()
        collectionView.delegate = self
        collectionView.register(CartCell.self, forCellWithReuseIdentifier: CartCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        self.collectionView = collectionView
        view.addSubview(totalPrice)
        totalPrice.backgroundColor = .white
        totalPrice.textColor = UIColor(named: "darkBeige")
        totalPrice.layer.masksToBounds = true
        totalPrice.layer.cornerRadius = 15
        totalPrice.textAlignment = .justified
        view.addSubview(buttonBackground)
        view.addSubview(orderButton)
        view.addSubview(buttonBackground)
        
        buttonBackground.layer.cornerRadius = 15
        buttonBackground.layer.masksToBounds = true
        buttonBackground.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(55)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
        buttonBackground.addSubview(orderButton)
        orderButton.setTitle("Order now", for: .normal)
        orderButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
        orderButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.edges.equalToSuperview()
        }
        totalPrice.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalTo(buttonBackground.snp.top).offset(-10)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(totalPrice.snp.top).offset(-10)
        }
        cartViewModel.reloadCollectionView = { [unowned self] () in
            DispatchQueue.main.async {
                self.isLoading = false
                self.collectionView?.reloadData()
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cartViewModel.getProductCounts()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CartCell.reuseIdentifier, for: indexPath) as! CartCell
        cell.updateUI(with: cartViewModel.getProduct(index: indexPath.item))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20
        return CGSize(width: width, height: 200)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = InfoModule.create(jewelery: cartViewModel.getProduct(index: indexPath.item))
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func clear() {
        cartViewModel.clearCart()
    }
    
}
