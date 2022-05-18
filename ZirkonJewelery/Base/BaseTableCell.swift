//
//  BaseTableCell.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//

import UIKit

class BaseTableCell<CellModel>: UITableViewCell {
    
    typealias CellModel = CellModel
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    var model: CellModel? {
        didSet {
            updateUI()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
    }
    
    func updateUI() {
        if let model = model {
            updateUI(with: model)
        }
    }
    
    func updateUI(with model: CellModel) {
        
    }
}
