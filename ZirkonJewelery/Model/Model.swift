//
//  Model.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import Foundation

struct CategoriesModel: Codable {
    let categoryName: String
    let items: [Items]
}

struct Items: Codable {
    let description: String
    let id: Int
    let image: String
    let name: String
    let price: String
}
