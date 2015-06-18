//
//  NovaDisciplinaTableViewController.swift
//  SemNome
//
//  Created by Mariana Alvarez on 15/06/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class NovaDisciplinaTableViewController: UITableViewController {

    @IBOutlet weak var nomeDisciplina: UITextField!
    @IBOutlet weak var semestreDisciplina: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func salvaDisciplina(sender: AnyObject) {
        var disciplina = DisciplinaManager.sharedInstance.novaDisciplina()
        disciplina.nome = nomeDisciplina.text
        disciplina.semestre = NSNumber(integer: semestreDisciplina.text.toInt()!)
        DisciplinaManager.sharedInstance.salvar()
        self.navigationController?.popViewControllerAnimated(true)
    }

}
