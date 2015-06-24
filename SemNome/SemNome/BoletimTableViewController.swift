//
//  BoletimTableViewController.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/23/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class BoletimTableViewController: UITableViewController {
    
    lazy var disciplinas = {
        return DisciplinaManager.sharedInstance.buscarDisciplinas()
        }()
    var disciplinasOrdenadas = [Disciplina]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        disciplinas = DisciplinaManager.sharedInstance.buscarDisciplinas()
        disciplinasOrdenadas.removeAll(keepCapacity: true)
        disciplinasOrdenadas = disciplinas
        disciplinasOrdenadas.sort() { $0.semestre.compare( $1.semestre ) == NSComparisonResult.OrderedAscending }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return disciplinasOrdenadas.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let disciplina = disciplinasOrdenadas[section]
        return "\(disciplina.nome) - \(disciplina.semestre) semestre"
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disciplinasOrdenadas[section].atividades.allObjects.count + 1
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaBoletim", forIndexPath: indexPath) as! UITableViewCell
        
        let numeroDeLinhas = disciplinasOrdenadas[indexPath.section].atividades.allObjects.count
        if indexPath.row < numeroDeLinhas {
            let item = disciplinasOrdenadas[indexPath.section].atividades.allObjects[indexPath.row] as! Atividade
            cell.textLabel?.text = item.nome
            cell.detailTextLabel?.text = "\(item.nota)"
        } else {
            var soma = 0.0
            var peso = 0.0
            let disc = disciplinasOrdenadas[indexPath.section]
            for ativ in disc.atividades {
                let atividade = ativ as! Atividade
                soma += atividade.nota.doubleValue * atividade.peso.doubleValue
                peso += atividade.peso.doubleValue
            }
            let media = soma/peso
            cell.textLabel?.text = "Média"
            cell.detailTextLabel?.text = "\(media)"
            cell.userInteractionEnabled = false
        }

        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detalhe = segue.destinationViewController as? DetailTableViewController {
            let indiceMateria = tableView.indexPathForSelectedRow()!.section
            let indiceAtividade = tableView.indexPathForSelectedRow()!.row
            let atividade = disciplinasOrdenadas[indiceMateria].atividades.allObjects[indiceAtividade] as! Atividade
            detalhe.atividade = atividade
        }
    }
    
    
}
