//
//  AvaliacaoViewController.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/18/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class AvaliacaoViewController: UIViewController {

    var atividade : Atividade?
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = atividade?.nome
        
        label.text = "Nome: \(atividade!.nome)\nData: \(atividade!.dia)\nNota: \(atividade!.nota)\nTipo: \(atividade!.tipo)\nDisciplina: \(atividade!.disciplina.nome)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
