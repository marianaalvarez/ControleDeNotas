//
//  DisciplinaManager.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/18/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import CoreData
import UIKit

public class DisciplinaManager {
    static let sharedInstance = DisciplinaManager()
    static let entityName = "Disciplina"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func novaDisciplina() -> Disciplina {
        return NSEntityDescription.insertNewObjectForEntityForName(DisciplinaManager.entityName, inManagedObjectContext: managedContext) as! Disciplina
    }
    
    func salvar() {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func buscarDisciplinas() -> [Disciplina] {
        let fetchRequest = NSFetchRequest(entityName: DisciplinaManager.entityName)
        let sortDescriptor = NSSortDescriptor(key: "semestre", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Disciplina] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        return [Disciplina]()
    }
    
    func deletar(disciplina: Disciplina) {
        managedContext.deleteObject(disciplina)
        salvar()
    }
}