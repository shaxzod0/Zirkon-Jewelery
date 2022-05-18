//
//  Header.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class Header: UICollectionReusableView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    static let identifier = "headerCat"
    let sloganText = UILabel()
    let searchTF = UITextField()
    let font: UIFont = .systemFont(ofSize: 25)
    var currentSelected: Int = 0
    var delegate: getCategoryNameProtocol?
    weak var collectionView: UICollectionView?
    let viewModel = CategoryViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews(){
        self.addSubview(sloganText)
        sloganText.text = "Best jewellery \nfor you"
        sloganText.textAlignment = .left
        sloganText.numberOfLines = 0
        sloganText.textColor = UIColor(named: "darkBeige")
        sloganText.font = .systemFont(ofSize: 50, weight: .bold)
        sloganText.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        self.addSubview(searchTF)
        let imageView = UIImageView(frame: CGRect(x: 8, y: 8, width: 26, height: 24))
        let image = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        imageView.image = image
        imageView.contentMode = .scaleToFill
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        view.addSubview(imageView)
        searchTF.leftViewMode = .always
        searchTF.leftView = view
        searchTF.backgroundColor = .white
        searchTF.placeholder = "Search jewellery"
        searchTF.layer.cornerRadius = 15
        searchTF.snp.makeConstraints { make in
            make.top.equalTo(sloganText.snp.bottom).offset(20)
            make.height.equalTo(55)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        }
        let l = UICollectionViewFlowLayout()
        l.scrollDirection = .horizontal
        l.minimumLineSpacing = 10
        l.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: l)
        self.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.reuseIdentifier)
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(searchTF.snp.bottom).offset(40)
            make.height.equalTo(self.snp.height).multipliedBy(0.15)
        }
        self.collectionView = collectionView
        viewModel.reloadCollectionView = { [unowned self] () in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCategoryCount()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text: String = viewModel.getCategoryName(index: indexPath.item).categoryName
        let width = text.widthOfString(usingFont: font) + 40
        return CGSize(width: width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCell.reuseIdentifier, for: indexPath) as! CategoriesCell
        cell.updateUI(with: viewModel.getCategoryName(index: indexPath.item))
        cell.setBackground(isSelected: currentSelected == indexPath.item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentSelected = indexPath.item
        delegate?.getCategoryName(indexPath.item)
        self.collectionView?.reloadData()
    }
    
}
