//
//  StatusDataManager.swift
//  ZirkonJewelery
//
//  Created by Shaxzod Azamatjonov on 24/05/22.
//

import UIKit
import CoreData

class StatusDataManager {
    static let shared = StatusDataManager()
    
    func orderStatus(orderId: Int, compilation: @escaping (Result<Bool, Error>)-> Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{
            compilation(.failure(NSError(domain: "App delegate not found", code: 555)))
            return
        }
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Status", in: context)
        let favObject = NSManagedObject(entity: entity!, insertInto: context)
        favObject.setValue(orderId, forKey: "id")
        do{
            try context.save()
            compilation(.success(true))
        }catch{
            compilation(.failure(error))
        }
    }
    func fetchFav(compilation: @escaping (Result <[NSManagedObject], Error>)->Void){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else{
            compilation(.failure(NSError(domain: "App delegate not found", code: 555)))
            return
        }
        let managedContext =
        delegate.persistentContainer.viewContext
        let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "Status")
        do {
            let fav = try managedContext.fetch(fetchRequest)
            compilation(.success(fav))
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func clearOrder(){
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let ctx = delegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: "Status")
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
