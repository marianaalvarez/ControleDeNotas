//
//  NovaAvaliacaoTableViewController.swift
//  SemNome
//
//  Created by Mariana Alvarez on 15/06/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class NovaAvaliacaoTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var nomeAvaliacao: UITextField!
    @IBOutlet weak var dataSelecionada: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tipoSelecionado: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var disciplina: Disciplina?
    
    let tiposDeAvaliacoes = ["Prova","Trabalho"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        nomeAvaliacao.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = disciplina?.nome
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nomeAvaliacao.resignFirstResponder()
        return true
    }

    @IBAction func datePickerAction(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        var dataEntrega = dateFormatter.stringFromDate(datePicker.date)
        self.dataSelecionada.text = dataEntrega
    }
    
    @IBAction func salvarAvaliacao(sender: AnyObject) {
        if nomeAvaliacao.text.isEmpty {
            var alert = UIAlertController(title: "Nome em Branco",
                message: "É necessário fornecer um nome para a atividade.",
                preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Ok",
                style: .Default) { (action: UIAlertAction!) -> Void in
            }
            
            alert.addAction(cancelAction)
            
            presentViewController(alert,
                animated: true,
                completion: nil)
        } else {
            var atividade = AtividadeManager.sharedInstance.novaAtividade()
            atividade.nome = nomeAvaliacao.text
            atividade.dia = datePicker.date
            if tipoSelecionado.text == "Trabalho" {
                atividade.tipo = 0
            } else {
                atividade.tipo = 1
            }
            atividade.disciplina = disciplina!
            AtividadeManager.sharedInstance.salvar()
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    // PickerView DataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tiposDeAvaliacoes.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return tiposDeAvaliacoes[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tipoSelecionado.text = tiposDeAvaliacoes[row]
    }
    
}
