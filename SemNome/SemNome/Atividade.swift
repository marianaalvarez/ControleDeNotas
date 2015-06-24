//
//  Atividade.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/24/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import Foundation
import CoreData

@objc(Atividade)
class Atividade: NSManagedObject {

    @NSManaged var dia: NSDate
    @NSManaged var nome: String
    @NSManaged var nota: NSNumber
    @NSManaged var notificacao: NSNumber
    @NSManaged var tipo: NSNumber
    @NSManaged var peso: NSNumber
    @NSManaged var disciplina: Disciplina

}
