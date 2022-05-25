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
        orderButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
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
    @objc func showAlert() {
        if cartViewModel.getProductCounts() == 0{
            emptyAlert()
        }else{
            alertToCall()
        }
    }
    func emptyAlert(){
        let alert = UIAlertController(title: "Your cart is Empty", message: "Please order some of our products", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    func alertToCall(){
        let randomInt = Int.random(in: 0..<1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let now = Date()
        let date = formatter.string(from: now)
        let alert = UIAlertController(title: "Thank you", message: "Our operators will contact you soon!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            
            guard let name = alert.textFields?[0].text else { return }
            guard let number = alert.textFields?[1].text else { return }
            
            UserDefaultsManager.shared.saveNumber(phone: number)
            UserDefaultsManager.shared.saveName(name: name)

            
            self.cartViewModel.reloadCollectionView = { [unowned self] in
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
            self.cartViewModel.saveOrderId()
            UserDefaultsManager.shared.orderNumber(orderNumber: randomInt)
            UserDefaultsManager.shared.saveDate(date: date)
            self.cartViewModel.clearCart()
            let vc = UINavigationController(rootViewController: TabBarController())
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false, completion: nil)
        }))
        alert.addTextField { textField in
            textField.placeholder = "Phone number"
            textField.text = "+998"
        }
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }
    
}
