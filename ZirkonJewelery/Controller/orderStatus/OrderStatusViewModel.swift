//
//  OrderStatusViewModel.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 24/05/22.
//

import UIKit
import CoreData

class OrderStatusViewModel {
    var productId: [NSManagedObject] = []
    init (){
        fetchStatus()
    }
    func fetchStatus(){
        StatusDataManager.shared.fetchFav { res in
            switch res{
            case .success(let data):
                self.productId = data
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func getProductCounts() -> Int {
        return productId.count
    }
    func isProductsEmpty() -> Bool {
        return productId.isEmpty
    }
    func clearOrder() {
        StatusDataManager.shared.clearOrder()
    }
}
