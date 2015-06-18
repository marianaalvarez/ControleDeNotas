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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = disciplina?.nome
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
            return disciplina!.atividades.allObjects.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = disciplina!.atividades.allObjects[indexPath.row] as! Atividade
        var cell = tableView.dequeueReusableCellWithIdentifier("celulaAvaliacao") as! UITableViewCell
        
        cell.textLabel?.text = item.nome
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let diaAtividade = dateFormatter.stringFromDate(item.data)
        cell.detailTextLabel?.text = diaAtividade
        
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destino = segue.destinationViewController as? NovaAvaliacaoTableViewController {
            destino.disciplina = disciplina
        }
    }

}
