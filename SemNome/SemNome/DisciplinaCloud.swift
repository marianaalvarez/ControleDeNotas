//
//  DisciplinaCloud.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/18/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit
import CloudKit

class DisciplinaCloud : NSObject {
    
    var record : CKRecord!
    weak var database : CKDatabase!
    var nome : String
    var semestre : NSNumber
    var nomeAtividades : [String]
    var dataAtividades : [NSDate]
    var notaAtividades : [NSNumber]
    var tipoAtividades : [NSNumber]
    
    init(record : CKRecord, database: CKDatabase) {
        self.record = record
        self.database = database
        
        self.nome = record.objectForKey("nome") as! String
        self.semestre = record.objectForKey("semestre") as! NSNumber
        self.nomeAtividades = record.objectForKey("nomeAtividades") as! [String]
        self.dataAtividades = record.objectForKey("dataAtividades") as! [NSDate]
        self.notaAtividades = record.objectForKey("notaAtividades") as! [NSNumber]
        self.tipoAtividades = record.objectForKey("tipoAtividades") as! [NSNumber]
    }
    
}