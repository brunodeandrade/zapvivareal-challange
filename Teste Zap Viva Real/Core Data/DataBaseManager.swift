//
//  DataBaseManager.swift
//  Teste Zap Viva Real
//
//  Created by Bruno Rodrigues de Andrade on 14/02/18.
//  Copyright © 2018 Bruno Rodrigues de Andrade. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class DataBaseManager: NSObject {
    
    static var games: [NSManagedObject] = []

    
    static func saveFavorite(gameObject: Game) -> Bool{
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Game",
                                       in: managedContext)!
        
        let game = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        game.setValue(gameObject.name, forKeyPath: "name")
        game.setValue(gameObject.viewers, forKeyPath: "viewers")
        if let image = gameObject.logoImage {
            let imageData = UIImagePNGRepresentation(image)
            game.setValue(imageData, forKey: "logoImageData")
        }
        game.setValue(true, forKey: "favorited")
        
        do {
            try managedContext.save()
            games.append(game)
            return true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }
    
    static func fetchData() -> [Game]{
        guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
    
        let managedContext = appDelegate.persistentContainer.viewContext
    
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Game")
    
        //3
        do {
            if let games = try managedContext.fetch(fetchRequest) as? [Game] {
                return games
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return []
    }
    
    static func removeFavorite() {
        
    }
}
