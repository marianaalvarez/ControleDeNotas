//
//  CalendarioTableViewController.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/18/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class CalendarioTableViewController: UITableViewController {

    var dias = [String]()
    var diasEAtividades = [String : [Atividade]]()
    lazy var disciplinas = {
        return DisciplinaManager.sharedInstance.buscarDisciplinas()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        disciplinas = DisciplinaManager.sharedInstance.buscarDisciplinas()
        
        // popula e ordena array de dias e gera dicionario
        self.dias.removeAll(keepCapacity: false)
        var diaSet = Set(self.dias)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        for disciplina in disciplinas {
            for atvdde in disciplina.atividades {
                let atividade = atvdde as! Atividade
                let diaString = dateFormatter.stringFromDate(atividade.dia)
                if !diaSet.contains(diaString) {
                    diaSet.insert(diaString)
                }
                diasEAtividades[diaString] = []
            }
        }
        self.dias = Array(diaSet)
        self.dias.sort() { $0.compare( $1 ) == NSComparisonResult.OrderedAscending }
        
        // popula dicionario
        for disciplina in disciplinas {
            for atvdde in disciplina.atividades {
                let atividade = atvdde as! Atividade
                let diaString = dateFormatter.stringFromDate(atividade.dia)
                var arrayAtividades = diasEAtividades[diaString]
                arrayAtividades!.append(atividade)
                diasEAtividades[diaString] = arrayAtividades
            }
        }
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dias.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let dia = dias[section]
        return diasEAtividades[dia]!.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dias[section]
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celulaCalendario", forIndexPath: indexPath) as! UITableViewCell
        
        let item = diasEAtividades[dias[indexPath.section]]![indexPath.row]
        cell.textLabel?.text = "\(item.disciplina.nome) - \(item.nome)"
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(item.dia)
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detalhe = segue.destinationViewController as? AvaliacaoViewController {
            let indiceDia = tableView.indexPathForSelectedRow()!.section
            let indiceAtividade = tableView.indexPathForSelectedRow()!.row
            let atividade = diasEAtividades[dias[indiceDia]]![indiceAtividade]
            detalhe.atividade = atividade as Atividade
        }

    }

}
