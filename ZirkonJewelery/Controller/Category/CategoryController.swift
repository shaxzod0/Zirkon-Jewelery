//
//  CategoryController.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class CategoryController: BaseViewController {

    weak var collectionView: UICollectionView?
    var delegate: getCategoryNameProtocol?
    let viewModel = CategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.navigationBar.topItem!.title = "Zirkon jewelery"
    }
}

extension CategoryController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, getCategoryNameProtocol {
    private func initViews() {
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .vertical
        l.minimumLineSpacing = 10
        l.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: l)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ItemsCell.self, forCellWithReuseIdentifier: ItemsCell.reuseIdentifier)
        collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.identifier)
        collectionView.backgroundColor = .clear
        collectionView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        self.collectionView = collectionView
        viewModel.reloadCollectionView = { [unowned self] in
            self.isLoading = false
            self.collectionView?.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getItemsCount()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemsCell.reuseIdentifier, for: indexPath) as! ItemsCell
        cell.updateUI(with: viewModel.getItems(i: indexPath.item))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 400)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 15
        return CGSize(width: width, height: 350)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.identifier, for: indexPath) as! Header
        header.delegate = self
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = InfoModule.create(jewelery: viewModel.getItems(i: indexPath.item))
        navigationController?.pushViewController(vc, animated: true)
    }
    func getCategoryName(_ categoryName: Int) {
        viewModel.index = categoryName
    }
}
