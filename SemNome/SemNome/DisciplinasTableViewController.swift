//
//  DisciplinasTableViewController.swift
//  SemNome
//
//  Created by Mariana Alvarez on 05/06/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit
import CoreData

class DisciplinasTableViewController: UITableViewController, UITableViewDataSource {

    lazy var disciplinas = {
        return DisciplinaManager.sharedInstance.buscarDisciplinas()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.tintColor = UIColor.redColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        disciplinas = DisciplinaManager.sharedInstance.buscarDisciplinas()
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return disciplinas.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = disciplinas[indexPath.row]
        var cell = tableView.dequeueReusableCellWithIdentifier("ceulaDisciplina") as! UITableViewCell
        
        cell.textLabel?.text = item.nome
        cell.detailTextLabel?.text = "Semestre: \(item.semestre)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let disciplina = disciplinas[indexPath.row] as Disciplina
            DisciplinaManager.sharedInstance.deletar(disciplina)
            disciplinas.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            
            for disciplina in disciplinas {
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
        if let destino = segue.destinationViewController as? AvaliacoesTableViewController {
            destino.disciplina = disciplinas[tableView.indexPathForSelectedRow()!.row]
        }
    }

}
