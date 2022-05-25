//
//  OrderStatusController.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 24/05/22.
//

import UIKit

class OrderStatusController: BaseViewController {
    let userInfoView = UIStackView()
    let viewModel = OrderStatusViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
//        if viewModel.isProductsEmpty() {
//            notOrderedView()
//        }else {
//            initViews()
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.navigationBar.topItem!.title = "Order status"
        if viewModel.isProductsEmpty() {
            notOrderedView()
        }else {
            initViews()
        }
    }
}

extension OrderStatusController {
    private func notOrderedView(){
        let notOrderedMessage = UILabel()
        view.addSubview(notOrderedMessage)
        notOrderedMessage.text = "You are not ordered"
        notOrderedMessage.numberOfLines = 0
        notOrderedMessage.textAlignment = .center
        notOrderedMessage.font = .systemFont(ofSize: 30)
        notOrderedMessage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
    private func initViews(){
        let orderNumber = UILabel()
        view.addSubview(orderNumber)
        orderNumber.text = "Order #\(UserDefaultsManager.shared.getOrderNumber())"
        orderNumber.font = .systemFont(ofSize: 25, weight: .bold)
        orderNumber.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            make.left.right.equalToSuperview().inset(30)
        }
        let cancelOrderButton = RectButton(image: nil, title: "Cancel my order", frame: .zero)
        cancelOrderButton.addTarget(self, action: #selector(cancelOrder), for: .touchUpInside)
        view.addSubview(cancelOrderButton)
        cancelOrderButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(orderNumber.snp.bottom).offset(20)
            make.width.centerX.equalToSuperview()
            make.bottom.equalTo(cancelOrderButton.snp.top).offset(-20)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.centerX.width.bottom.equalToSuperview()
        }
        
        let orderAcceptedView = UIView()
        contentView.addSubview(orderAcceptedView)
        orderAcceptedView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(90)
            make.top.left.equalToSuperview().offset(20)
        }
        let acceptImage = UIImageView()
        orderAcceptedView.addSubview(acceptImage)
        acceptImage.image = UIImage(named: "orderAccept")
        acceptImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        let acceptMessage = UILabel()
        orderAcceptedView.addSubview(acceptMessage)
        acceptMessage.text = "Your order was accepted"
        acceptMessage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(acceptImage.snp.right).inset(-5)
        }
        let acceptedDate = UILabel()
        orderAcceptedView.addSubview(acceptedDate)
        acceptedDate.text = "Date: \(UserDefaultsManager.shared.getDate())"
        acceptedDate.snp.makeConstraints { make in
            make.top.equalTo(acceptMessage.snp.bottom)
            make.left.equalTo(acceptImage.snp.right).inset(-5)
        }
        let waitOperatorsView = UIView()
        contentView.addSubview(waitOperatorsView)
        waitOperatorsView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(90)
            make.top.equalTo(orderAcceptedView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        let waitOperatorsImage = UIImageView()
        waitOperatorsView.addSubview(waitOperatorsImage)
        waitOperatorsImage.image = UIImage(named: "wait")
        waitOperatorsImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        let waitDate = UILabel()
        waitOperatorsView.addSubview(waitDate)
        waitDate.numberOfLines = 0
        waitDate.text = "Please wait\nour operators will\ncontact you soon"
        waitDate.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(waitOperatorsImage.snp.right).inset(-5)
        }
        
        let onTheWayView = UIView()
        contentView.addSubview(onTheWayView)
        onTheWayView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(90)
            make.top.equalTo(waitOperatorsView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        let onTheWayImage = UIImageView()
        onTheWayView.addSubview(onTheWayImage)
        onTheWayImage.image = UIImage(named: "onWay")
        onTheWayImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        let onTheWayMessage = UILabel()
        onTheWayView.addSubview(onTheWayMessage)
        onTheWayMessage.text = "Your order is on the way"
        onTheWayMessage.numberOfLines = 0
        onTheWayMessage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(onTheWayImage.snp.right).inset(-5)
        }
        let wayDate = UILabel()
        onTheWayView.addSubview(wayDate)
        wayDate.text = "Date: pending"
        wayDate.snp.makeConstraints { make in
            make.top.equalTo(onTheWayMessage.snp.bottom).offset(5)
            make.left.equalTo(onTheWayImage.snp.right).inset(-5)
        }
        
        let recieveProductView = UIView()
        contentView.addSubview(recieveProductView)
        recieveProductView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(90)
            make.top.equalTo(onTheWayView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        let recieveImage = UIImageView()
        recieveProductView.addSubview(recieveImage)
        recieveImage.image = UIImage(named: "recieve")
        recieveImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(20)
        }
        let recieveMessage = UILabel()
        recieveProductView.addSubview(recieveMessage)
        recieveMessage.text = "Your order has been delivered"
        recieveMessage.numberOfLines = 0
        recieveMessage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(recieveImage.snp.right).inset(-5)
        }
        let recieveDate = UILabel()
        recieveProductView.addSubview(recieveDate)
        recieveDate.text = "Date: pending"
        recieveDate.snp.makeConstraints { make in
            make.top.equalTo(recieveMessage.snp.bottom).offset(5)
            make.left.equalTo(recieveImage.snp.right).inset(-5)
        }
        contentView.addSubview(userInfoView)
        userInfoView.layer.cornerRadius = 15
        userInfoView.backgroundColor = .white
        userInfoView.axis = .vertical
        userInfoView.distribution = .equalCentering
        userInfoView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.centerX.equalToSuperview()
            make.height.equalTo(70)
            make.top.equalTo(recieveProductView.snp.bottom).offset(30)
            make.bottom.equalToSuperview()
        }
        let userName = UILabel()
        userInfoView.addSubview(userName)
        userName.text = UserDefaultsManager.shared.getName()
        userName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().inset(20)
        }
        let userPhoneNumber = UILabel()
        userInfoView.addSubview(userPhoneNumber)
        userPhoneNumber.text = UserDefaultsManager.shared.getNumber()
        userPhoneNumber.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(20)
        }
        DispatchQueue.main.async {
            self.isLoading = false
        }
        
        print(scrollView.subviews.count)
    }
    @objc func cancelOrder(){
        alertToConfirm()
    }
    
    func alertToConfirm() {
        let alert = UIAlertController(title: "Cancel order", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { alert in
            self.viewModel.clearOrder()
            self.refreshView()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        present(alert, animated: true)
    }
    func refreshView() -> () {
        view.subviews.forEach({ $0.removeFromSuperview() })
        notOrderedView()
    }
}
