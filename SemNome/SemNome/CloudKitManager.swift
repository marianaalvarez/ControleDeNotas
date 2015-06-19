//
//  CloudKitManager.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/18/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import Foundation
import CloudKit


protocol CloudKitManagerDelegate {
    func errorUpdating(error: NSError)
    func modelUpdated()
}

@objc class CloudKitManager {
    
    class func sharedInstance() -> CloudKitManager {
        return CloudKitManagerSingleton
    }
    
    var delegate : CloudKitManagerDelegate?
    
    var disciplinas = [DisciplinaCloud]()
    
    let container : CKContainer
    let publicDB : CKDatabase
    let privateDB : CKDatabase
    
    init() {
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        privateDB = container.privateCloudDatabase
    }
    
    func fetchDisciplinas() {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Disciplinas", predicate: predicate)
        publicDB.performQuery(query, inZoneWithID: nil) { results, error in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.errorUpdating(error)
                    println("error loading: \(error)")
                }
            } else {
                self.disciplinas.removeAll(keepCapacity: true)
                for record in results {
                    let disciplina = DisciplinaCloud(record: record as! CKRecord, database:self.publicDB)
                    self.disciplinas.append(disciplina)
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.delegate?.modelUpdated()
                }
            }
        }
    }
    
}

let CloudKitManagerSingleton = CloudKitManager()