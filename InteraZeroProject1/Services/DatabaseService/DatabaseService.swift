//
//  DatabaseService.swift
//  InteraZeroProject1
//
//  Created by Sara Talat on 29/07/2024.
//

import Foundation
import CoreData
import UIKit

class DatabaseService {
    
    let managedContext: NSManagedObjectContext?
    let appDelegate: AppDelegate?
    
    
    static let instance = DatabaseService()
    private init(){
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
    }
    
    var starshipArray: [LocalStarship] = []
    var starshipNSManagedObjectArray: [NSManagedObject] = []
    
    var characterArray: [LocalCharacter] = []
    var characterNSManagedObjectArray: [NSManagedObject] = []
    

    
    func saveStarshipToCoreData(name: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StarshipEntity")
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext?.fetch(fetchRequest)
            if let existingStarship = results?.first as? NSManagedObject {
                existingStarship.setValue(name, forKey: "name")
            } else {

                let defaultContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
                let context = managedContext ?? defaultContext
                
                guard let context = context else {
                    print("Error: No valid managed context found")
                    return
                }
                
                guard let entity = NSEntityDescription.entity(forEntityName: "StarshipEntity", in: context) else {
                    print("Error: Entity not found")
                    return
                }
                
                let starshipManagerObject = NSManagedObject(entity: entity, insertInto: context)
                starshipManagerObject.setValue(name, forKey: "name")
            }
            
            try managedContext?.save()
        } catch let error as NSError {
            print("Error saving to CoreData: \(error.localizedDescription)")
        }
    }
    
    func saveCharacterToCoreData(name: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CharacterEntity")
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        
        do {
            let results = try managedContext?.fetch(fetchRequest)
            if let existingCharacter = results?.first as? NSManagedObject {
                existingCharacter.setValue(name, forKey: "name")
            } else {

                let defaultContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
                let context = managedContext ?? defaultContext
                
                guard let context = context else {
                    print("Error: No valid managed context found")
                    return
                }
                
                guard let entity = NSEntityDescription.entity(forEntityName: "StarshipEntity", in: context) else {
                    print("Error: Entity not found")
                    return
                }
                
                let characterManagerObject = NSManagedObject(entity: entity, insertInto: context)
                characterManagerObject.setValue(name, forKey: "name")
            }
            
            try managedContext?.save()
        } catch let error as NSError {
            print("Error saving to CoreData: \(error.localizedDescription)")
        }
    }


    
    
    func retriveStarshipsFromCoreData() -> [LocalStarship]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "StarshipEntity")
        do{
           
            starshipNSManagedObjectArray = try managedContext.fetch(fetchRequest)
            
            starshipArray = starshipNSManagedObjectArray.compactMap { (managedObject) -> LocalStarship? in
                guard let name = managedObject.value(forKey: "name") as? String
                else {
                    return nil
                }
                
                return LocalStarship(name: name)

            }
            return starshipArray
            
            

        }catch let error as NSError {
            print("Error retrieving data: \(error.localizedDescription)")
            return []
        }
        
    }
    
    func retriveCharactersFromCoreData() -> [LocalCharacter]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CharacterEntity")
        do{
           
            characterNSManagedObjectArray = try managedContext.fetch(fetchRequest)
            
            characterArray = characterNSManagedObjectArray.compactMap { (managedObject) -> LocalCharacter? in
                guard let name = managedObject.value(forKey: "name") as? String
                else {
                    return nil
                }
                return LocalCharacter(name: name)
            }
            
            return characterArray
            
            

        }catch let error as NSError {
            print("Error retrieving data: \(error.localizedDescription)")
            return []
        }
        
    }


    
    func deleteStarshipFromCoreData(name: String) -> [LocalStarship] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StarshipEntity")
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        
        do {
            if let result = try managedContext.fetch(fetchRequest).first as? NSManagedObject {
                managedContext.delete(result)
                try managedContext.save()
                return retriveStarshipsFromCoreData()
            } else {
                print("Starship with name \(name) not found")
                return []
            }
        } catch let error as NSError {
            print("Error deleting from Core Data: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteCharacterFromCoreData(name: String) -> [LocalCharacter] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CharacterEntity")
        let predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.predicate = predicate
        
        do {
            if let result = try managedContext.fetch(fetchRequest).first as? NSManagedObject {
                managedContext.delete(result)
                try managedContext.save()
                return retriveCharactersFromCoreData()
            } else {
                print("Character with name \(name) not found")
                return []
            }
        } catch let error as NSError {
            print("Error deleting from Core Data: \(error.localizedDescription)")
            return []
        }
    }
    
    
//    func deleteAllFromCoreData() -> [NSManagedObject] {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavouriteEntity")
//
//        do {
//            let results = try managedContext.fetch(fetchRequest)
//            for object in results {
//                if let league = object as? NSManagedObject {
//                    managedContext.delete(league)
//                }
//            }
//            try managedContext.save()
//            return retriveLeaguesFromCoreData()
//        } catch let error as NSError {
//            print("Error deleting from Core Data: \(error.localizedDescription)")
//            return []
//        }
//    }

    
    
    
}
