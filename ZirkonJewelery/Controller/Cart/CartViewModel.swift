//
//  CartViewModel.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import Foundation
import CoreData

class CartViewModel {
    private var productData: [NSManagedObject] = [] {
        didSet {
            self.reloadCollectionView?()
        }
    }
    private var totalPrice: [Float] = [] {
        didSet {
            self.reloadCollectionView?()
        }
    }
    init() {
        fetchProducts()
    }
    
    func getProducts() -> [Items] {
        var products: [Items] = []
        for data in productData {
            let desc = data.value(forKey: "desc") as! String
            let image = data.value(forKey: "image") as! String
            let name = data.value(forKey: "name") as! String
            let price = data.value(forKey: "price") as! String
            let id = data.value(forKey: "id") as! Int
            products.append(Items(description: desc, id: id, image: image, name: name, price: price))
        }
        return products
    }
    func getProduct(index: Int) -> Items {
        let description = productData[index].value(forKey: "desc") as! String
        let name = productData[index].value(forKey: "name") as! String
        let image = productData[index].value(forKey: "image") as! String
        let price = productData[index].value(forKey: "price") as! String
        let id: Int = productData[index].value(forKey: "id") as! Int
        let product = Items(description: description , id: id, image: image, name: name, price: price)
        return product
    }

    func getTotalPrice() -> Float {
        
        let products = getProducts()
        var totalPrice: Float = 0
        for product in products {
            let price = product.price
            var dropfirst = price
            dropfirst.remove(at: dropfirst.startIndex)
            let priceInt = dropfirst.replacingOccurrences(of: ",", with: "", options: NSString.CompareOptions.literal, range: nil)
            totalPrice += Float(priceInt) ?? 0

        }
       
        
        
        return totalPrice
    }
    func getProductCounts() -> Int {
        return productData.count
    }
    func isProductsEmpty() -> Bool {
        return productData.isEmpty
    }
    func fetchProducts(){
        CartDataManager.shared.fetchCart { res in
            switch res{
            case .success(let data):
                self.productData = data
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func saveOrderId() {
        StatusDataManager.shared.orderStatus(orderId: 1) { res in
            switch res{
            case .success(_):break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func clearCart() {
        CartDataManager.shared.clearCart()
    }
    var reloadCollectionView: (()->())?
}
