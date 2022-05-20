//
//  InfoModule.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class InfoModule {
    static func create(jewelery: Items) -> UIViewController {
        let dataManager = FavoriteDataManager()
        let cartDataManager = CartDataManager()
        let vm = InfoViewModel(manager: dataManager, info: jewelery, cartManager: cartDataManager)
        let vc = ItemInformationController(vm: vm)
        return vc
    }
}

