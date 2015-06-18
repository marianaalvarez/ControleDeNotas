//
//  Atividade.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/18/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import Foundation
import CoreData

@objc(Atividade)
class Atividade: NSManagedObject {

    @NSManaged var data: NSDate
    @NSManaged var nome: String
    @NSManaged var nota: NSNumber
    @NSManaged var tipo: NSNumber
    @NSManaged var disciplina: Disciplina

}
