//
//  ReactButton.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class RectButton: UIButton {
    init(image: UIImage?, title: String, frame: CGRect) {
        super.init(frame: frame)
        initView(image: image, title: title)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func initView(image: UIImage?, title: String) {
        setImage(image, for: .normal)
        setTitle(title, for: .normal)
        contentHorizontalAlignment = .center
        self.contentEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
        backgroundColor = .buttonBackground
        tintColor = .white
        translatesAutoresizingMaskIntoConstraints = false
    }
}
