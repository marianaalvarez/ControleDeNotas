//
//  AvaliacoesTableViewController.swift
//  SemNome
//
//  Created by Mariana Alvarez on 05/06/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class AvaliacoesTableViewController: UITableViewController {

    var disciplina: Disciplina?
    var atividades = [Atividade]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = disciplina?.nome
        
        atividades = disciplina?.atividades.allObjects as! [Atividade]
        atividades.sort() { $0.dia.compare($1.dia) == NSComparisonResult.OrderedAscending }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = disciplina?.atividades.count {
            return atividades.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = atividades[indexPath.row] as Atividade
        var cell = tableView.dequeueReusableCellWithIdentifier("celulaAvaliacao") as! UITableViewCell
        
        cell.textLabel?.text = item.nome
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let diaAtividade = dateFormatter.stringFromDate(item.dia)
        cell.detailTextLabel?.text = diaAtividade
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let atividade = atividades[indexPath.row] as Atividade
            AtividadeManager.sharedInstance.deletar(atividade)
            atividades.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
            for disciplina in DisciplinaManager.sharedInstance.buscarDisciplinas() {
                for atividade in disciplina.atividades.allObjects as! [Atividade] {
                    if atividade.notificacao == 1 {
                        LocalNotificationManager.sharedInstance.criaNotificacao(atividade)
                    }
                }
            }
        }
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let nova = segue.destinationViewController as? NovaAvaliacaoViewController {
            nova.disciplina = disciplina
        } else if let detalhe = segue.destinationViewController as? DetailTableViewController {
            detalhe.atividade = atividades[tableView.indexPathForSelectedRow()!.row] as Atividade
        }
    }

}
