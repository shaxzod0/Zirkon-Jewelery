//
//  IntroCell.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 18/05/22.
//

import UIKit

class IntroCell: BaseCollectionCell<IntroModel> {
    let introImage = UIImageView()
    
    override func initViews() {
        self.addSubview(introImage)
        introImage.image = UIImage(named: "first")
        introImage.contentMode = .scaleToFill
        introImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func updateUI(with model: IntroModel) {
        introImage.image = UIImage(named: model.image)
    }
}
