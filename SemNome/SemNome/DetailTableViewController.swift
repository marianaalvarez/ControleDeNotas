//
//  DetailTableViewController.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/19/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var atividade : Atividade?
    

    @IBOutlet weak var disciplina: UILabel!
    @IBOutlet weak var nota: UILabel!
    @IBOutlet weak var data: UILabel!
    @IBOutlet weak var tipo: UILabel!
    @IBOutlet weak var notificacao: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
        navigationItem.title = atividade?.nome
        
        disciplina.text = atividade?.disciplina.nome
        nota.text = "\(atividade!.nota)"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        data.text = dateFormatter.stringFromDate(atividade!.dia)
        if atividade?.tipo == 1 {
            tipo.text = "Prova"
        } else {
            tipo.text = "Trabalho"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editar = segue.destinationViewController as! EditarViewController
        editar.atividade = atividade
    }
    
}
