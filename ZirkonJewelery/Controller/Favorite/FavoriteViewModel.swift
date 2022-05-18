//
//  FavoriteViewModel.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit
import CoreData

class FavoriteViewModel {
    var productData: [NSManagedObject] = [] {
        didSet {
            self.reloadTableView?()
        }
    }
    init() {
        fetchProducts()
    }
    func getProducts() -> [Items] {
        var products: [Items] = []
        for data in productData {
            let description = data.value(forKey: "desc") as! String
            let name = data.value(forKey: "name") as! String
            let image = data.value(forKey: "image") as! String
            let price = data.value(forKey: "price") as! String
            let id: Int = data.value(forKey: "id") as! Int
            products.append(Items(description: description , id: id, image: image, name: name, price: price))
        }
        return products
    }
    func getProductCount() -> Int {
        return productData.count
    }
    func getProduct(index: Int) -> Items {
        let description = productData[index].value(forKey: "desc") as! String
        let name = productData[index].value(forKey: "name") as! String
        let image = productData[index].value(forKey: "image") as! String
        let price = productData[index].value(forKey: "price") as! String
        let id: Int = productData[index].value(forKey: "id") as! Int
        let prodruct = Items(description: description , id: id, image: image, name: name, price: price)
        return prodruct
    }
    func isProductsEmpty() -> Bool {
        return productData.isEmpty
    }
    func deleteProduct(productId: Int) {
        FavoriteDataManager.shared.deleteRecords(product: productId) { res in
            switch res{
            case .success(_):
                print("succes")
            case.failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func fetchProducts(){
        FavoriteDataManager.shared.fetchFav { res in
            switch res{
            case .success(let data):
                self.productData = data
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    var reloadTableView: (()->())?
}
