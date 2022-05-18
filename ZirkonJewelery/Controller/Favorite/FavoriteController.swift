//
//  FavoriteController.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class FavoriteController: UIViewController {
    let viewModel = FavoriteViewModel()
    let tableView = UITableView()
    var isDelete = true
    let emptyLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        initViews()
        emptyLabel.isHidden = !viewModel.isProductsEmpty()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.navigationBar.topItem!.title = "Favorites"
        viewModel.fetchProducts()
        emptyLabel.isHidden = !viewModel.isProductsEmpty()
    }
}

extension FavoriteController: UITableViewDelegate, UITableViewDataSource {
    private func initViews() {
        view.addSubview(emptyLabel)
        emptyLabel.text = "Not favorite products"
        emptyLabel.font = .systemFont(ofSize: 25, weight: .bold)
        emptyLabel.textAlignment = .center
        emptyLabel.numberOfLines = 0
        emptyLabel.textColor = .red
        emptyLabel.isHidden = false
        emptyLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        viewModel.reloadTableView = { [unowned self] in
            self.tableView.reloadData()
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseIdentifier, for: indexPath) as! FavoriteCell
        cell.updateUI(with: viewModel.getProduct(index: indexPath.item))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = InfoModule.create(jewelery: viewModel.getProduct(index: indexPath.item))
        navigationController?.pushViewController(vc, animated: true)
    }
}
