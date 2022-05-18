//
//  InfoViewModel.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class InfoViewModel {
    var inCart = true
    var isFav = true
    private var item: Items{
        didSet {
            self.updateUI!()
        }
    }
    var updateUI: (()->())?
    var dataManager: FavoriteDataManager
    var cartDataManager: CartDataManager
    init(manager: FavoriteDataManager, info: Items, cartManager: CartDataManager){
        self.dataManager = manager
        self.item = info
        self.cartDataManager = cartManager
    }
    func getItem() -> Items? {
        return item
    }
    func isInCart() -> String {
        if cartDataManager.checkItemExist(id: item.id){
            inCart = true
            return "Remove from cart"
        }
        else {
            inCart = false
            return "Save to cart"
        }
    }
    func isFavorite() -> Bool {
        isFav = dataManager.checkItemExist(id: item.id)
        return isFav
        
    }
    func manageCart() {
        if inCart{
            deleteFromCart()
        }else{
            saveToCart()
        }
    }
    func manageFav() {
        if isFav{
            deleteFav()
        } else {
            saveToFav()
        }
    }
    func saveToFav() {
        dataManager.saveToFav(product: item) { res in
            switch res{
            case .success(_): break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func deleteFav() {
        dataManager.deleteRecords(product: item.id) { res in
            switch res {
            case .success(_): break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func saveToCart() {
        cartDataManager.saveToCart(product: item) { res in
            switch res{
            case .success(_): break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    func deleteFromCart() {
        cartDataManager.deleteRecords(product: item.id) { res in
            switch res {
            case .success(_): break
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
}
