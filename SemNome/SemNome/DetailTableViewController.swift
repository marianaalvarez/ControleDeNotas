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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = atividade?.nome
    }
    
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "celulaDetalhe")

        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        
        var tipo = ""
        if atividade?.tipo == 1 {
            tipo = "Prova"
        } else {
            tipo = "Trabalho"
        }
        
        switch indexPath.section {
        case 0: cell.textLabel?.text = atividade?.disciplina.nome
            break
        case 1: cell.textLabel?.text = dateFormatter.stringFromDate(atividade!.dia)
            break
        case 2: cell.textLabel?.text = tipo
            break
        case 3: cell.textLabel?.text = "\(atividade!.nota)"
            break
        default: cell.textLabel?.text = "Inválido"
        }
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let editar = segue.destinationViewController as! EditaAvaliacaoTableViewController
        editar.atividade = atividade
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
