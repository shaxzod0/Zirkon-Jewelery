//
//  CartDataManager.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 17/05/22.
//


import UIKit
import CoreData

class CartDataManager {
    static let shared = CartDataManager()
    
    func saveToCart(product: Items, compilation: @escaping (Result<Bool, Error>)-> Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{
            compilation(.failure(NSError(domain: "App delegate not found", code: 555)))
            return
        }
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Cart", in: context)
        let favObject = NSManagedObject(entity: entity!, insertInto: context)
        favObject.setValue(product.id, forKey: "id")
        favObject.setValue(product.name, forKey: "name")
        favObject.setValue(product.description, forKey: "desc")
        favObject.setValue(product.price, forKey: "price")
        favObject.setValue(product.image, forKey: "image")
        do{
            try context.save()
            compilation(.success(true))
        }catch{
            compilation(.failure(error))
        }
    }
    func fetchCart(compilation: @escaping (Result <[NSManagedObject], Error>)->Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{
            compilation(.failure(NSError(domain: "App delegate not found", code: 555)))
            return
        }
        let managedContext =
        delegate.persistentContainer.viewContext
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Cart")
        do {
            let fav = try managedContext.fetch(fetchRequest)
            compilation(.success(fav))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func deleteRecords(product: Int,complation: @escaping (Result<Bool, Error>)->Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            complation(.failure(NSError(domain: "Appdelegate not found", code: 404, userInfo: nil)))
            return
        }
        let ctx = delegate.persistentContainer.viewContext
        let requestDel = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        requestDel.returnsObjectsAsFaults = false
        do {
            let arrUsrObj = try ctx.fetch(requestDel)
            for usrObj in arrUsrObj as! [NSManagedObject] {
                if usrObj.value(forKey: "id") as! Int == product {
                        ctx.delete(usrObj) // Deleting Object
                }
            }
        } catch {
            print("Failed")
        }
        do {
            try ctx.save()
        } catch {
            print("Failed saving")
        }
    }
    func checkItemExist(id: Int) -> Bool {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        let managedContext = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "id == %d" ,id)
        do {
            let count = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    func clearCart(){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let ctx = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Cart")
        request.returnsObjectsAsFaults = false
        do {
            let results = try ctx.fetch(request)
            for object in results {
                ctx.delete(object)
            }
            try ctx.save()
        } catch let error {
            print("Detele all data in error :", error)
        }
    }
}
