//
//  TabBarController.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    private func initViews() {
        let category = CategoryController()
        let favorite = FavoriteController()
        let cart = CartController()
        
        category.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "unsel")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray), selectedImage: UIImage(named: "diamond")?.withRenderingMode(.alwaysOriginal))
        favorite.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "favUns")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray), selectedImage: UIImage(named: "favSel")?.withRenderingMode(.alwaysOriginal))
        cart.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "cartUns")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray), selectedImage: UIImage(named: "cartSel")?.withRenderingMode(.alwaysOriginal))
        viewControllers = [category, favorite, cart]
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 25
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
