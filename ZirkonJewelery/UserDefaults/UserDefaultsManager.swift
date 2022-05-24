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
    let userNameKey = "name"
    let phoneNumberKey = "phone"
    let orderKey = "order"
    let orderDate = "date"
    func saveAuth(reg: Bool?){
        defaults.set(reg, forKey: authKey)
    }
    func isReg()->Bool{
        return defaults.bool(forKey: authKey)
    }
    func saveName(name: String?){
        defaults.set(name, forKey: userNameKey)
    }
    func getName()->String {
        return defaults.string(forKey: userNameKey) ?? "Username"
    }
    func saveNumber(phone: String?){
        defaults.set(phone, forKey: phoneNumberKey)
    }
    func getNumber()->String {
        return defaults.string(forKey: phoneNumberKey) ?? "998"
    }
    func orderNumber(orderNumber: Int) {
        defaults.set(orderNumber, forKey: orderKey)
    }
    func getOrderNumber()->Int{
        return defaults.integer(forKey: orderKey)
    }
    func saveDate(date: String) {
        defaults.set(date, forKey: orderDate)
    }
    func getDate() -> String {
        return defaults.string(forKey: orderDate) ?? "Pending"
    }
}
