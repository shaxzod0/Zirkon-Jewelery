//
//  UserDefaultsManager.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 18/05/22.
//

import Foundation

class UserDefaultsManager {
    let defaults = UserDefaults.standard
    static let shared = UserDefaultsManager()
    let authKey = "auth"
    func saveAuth(reg: Bool?){
        defaults.set(reg, forKey: authKey)
    }
    func isReg()->Bool{
        return defaults.bool(forKey: authKey)
    }
}
