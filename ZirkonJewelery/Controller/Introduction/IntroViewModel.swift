//
//  IntroViewModel.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 18/05/22.
//

import UIKit

struct IntroModel {
    let image: String
}
class IntroViewModel {
    let data: [IntroModel] = [
        IntroModel(image: "first"),
        IntroModel(image: "second"),
        IntroModel(image: "third")
    ]
    
    func getIntroCount() -> Int {
        return data.count
    }
    func getIntro(index: Int) ->IntroModel {
        let image = data[index].image
        return IntroModel(image: image)
    }
}
