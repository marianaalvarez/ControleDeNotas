//
//  NovaAvaliacaoTableViewController.swift
//  SemNome
//
//  Created by Mariana Alvarez on 15/06/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class NovaAvaliacaoTableViewController: UITableViewController {

    @IBOutlet weak var nomeAvaliacao: UITextField!
    @IBOutlet weak var dataSelecionada: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func datePickerAction(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        var dataEntrega = dateFormatter.stringFromDate(datePicker.date)
        self.dataSelecionada.text = dataEntrega
    }
    
    @IBAction func salvarAvaliacao(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
