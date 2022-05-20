//
//  CategoryViewModel.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class CategoryViewModel {
    var index: Int? {
        didSet {
            self.reloadCollectionView?()
        }
    }
    private var categories: [CategoriesModel] = [] {
        didSet {
            self.reloadCollectionView?()
        }
    }
    private var items: [Items] = [] {
        didSet {
            self.reloadCollectionView?()
        }
    }
    init() {
        getCategories()
        getItems()
    }
    func getCategoryName(index: Int) -> CategoriesModel {
        let categoryName = categories[index]
        return categoryName
    }
    func getItems(i: Int) -> Items {
        let description = categories[index ?? 0].items[i].description
        let id = categories[index ?? 0].items[i].id
        let image = categories[index ?? 0].items[i].image
        let name = categories[index ?? 0].items[i].name
        let price = categories[index ?? 0].items[i].price
        let product = Items(description: description, id: id, image: image, name: name, price: price)
        return product
    }
    func getCategoryCount() -> Int {
        return categories.count
    }
    func getCategoryItems() -> Items {
        return items[index ?? 0]
    }
    
    func getItemsCount() -> Int {
        return items.count
    }
    func getCategories() {
        CategoriesRepository.shared.getCategories { res in
            self.categories = res
        }
    }
    func getItems() {
        CategoriesRepository.shared.getCategories { res in
            self.items = res[self.index ?? 0].items
        }
    }
    var reloadCollectionView: (()->())?
}