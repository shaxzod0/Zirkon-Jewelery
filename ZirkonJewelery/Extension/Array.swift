//
//  Array.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 25/05/22.
//

import Foundation

extension Array {
    func element(at index: Int) -> Element? {
        return index < self.count ? self[index] : nil
    }
}
