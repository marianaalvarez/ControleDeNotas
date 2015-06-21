//
//  AtividadeManager.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/18/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import CoreData
import UIKit

public class AtividadeManager {
    static let sharedInstance = AtividadeManager()
    static let entityName = "Atividade"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func novaAtividade() -> Atividade {
        return NSEntityDescription.insertNewObjectForEntityForName(AtividadeManager.entityName, inManagedObjectContext: managedContext) as! Atividade
    }
    
    func salvar() {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarAtividades() -> [Atividade] {
        let fetchRequest = NSFetchRequest(entityName: AtividadeManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Atividade] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        return [Atividade]()
    }
    
    func atualizaAtividade(atividade: NSManagedObject){
//        
//        let novaAtividade : NSManagedObject = atividade as NSManagedObject
//        novaAtividade.setValue("mudou", forKey: "nome")
        
        var error:NSError?
        
        if ((atividade.managedObjectContext?.save(&error)) != nil) {
            println("Unable to save managed object context.")
            println("\(error)")
        }
    }
        
//        let fetchRequest = NSFetchRequest(entityName: AtividadeManager.entityName)
//        var error:NSError?
//        
//        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
//        
//        if let results = fetchedResults as? [Atividade] {
//            return results
//        } else {
//            println("Could not fetch. Error: \(error), \(error!.userInfo)")
//        }
//        
//        NSFetchRequest(entityName: "FetchRequest")
//        
//        return Atividade()
    
//    func atualizaAtividade(atividade: Atividade) -> Atividade {
//    
//        let fetchRequest : NSFetchRequest = NSFetchRequest(entityName: "Atividade")
//        var error : NSError? = nil
//        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
//        if error != nil {
//            println("An error occurred loading the data")
//        } else {
//            let result = results[indexPath.row]
//            result.count = result.count.integerValue + 1
//            var saveError : NSError? = nil
//            if !managedObjectContext!.save(&saveError) {
//                println("Could not update record")
//            } else {
//                names[indexPath.row] = result
//                tableView.reloadData()
//            }
//        }
//        
//        return
//    }

    
    func deletar(atividade: Atividade) {
        managedContext.deleteObject(atividade)
        salvar()
    }
}