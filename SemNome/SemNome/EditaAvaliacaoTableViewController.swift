//
//  EditaAvaliacaoTableViewController.swift
//  SemNome
//
//  Created by Mariana Alvarez on 20/06/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit
import CoreData


class EditaAvaliacaoTableViewController: UITableViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var nomeAvaliacao: UITextField!
    @IBOutlet weak var dataEntrega: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var tipoAvaliacao: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var notaAvaliacao: UITextField!
    let tiposDeAvaliacoes = ["Trabalho","Prova"]
    var atividade: Atividade?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        nomeAvaliacao.delegate = self
        notaAvaliacao.delegate = self
        
        nomeAvaliacao.text = atividade?.nome
        
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dataEntrega.text = dateFormatter.stringFromDate(atividade!.dia)
        datePicker.date = atividade!.dia
        
        if atividade?.tipo == 0 {
            tipoAvaliacao.text = "Trabalho"
        } else {
            tipoAvaliacao.text = "Prova"
            pickerView.selectRow(1, inComponent: 0, animated: true)
        }
        
        notaAvaliacao.text! = "\(atividade!.nota)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func salvaAvaliacao(sender: AnyObject) {
        
        if (atividade!.nome != nomeAvaliacao.text || atividade!.dia != datePicker.date || atividade!.nota != notaAvaliacao.text || atividade?.tipo != pickerView.selectedRowInComponent(0)) {
            
            let novaAtividade : NSManagedObject = atividade! as NSManagedObject
            novaAtividade.setValue(nomeAvaliacao.text, forKey: "nome")
            novaAtividade.setValue(datePicker.date, forKey: "dia")
            novaAtividade.setValue(pickerView.selectedRowInComponent(0), forKey: "tipo")
            var nota = NSNumber(double: (notaAvaliacao.text as NSString).doubleValue)
            novaAtividade.setValue(nota, forKey: "nota")
            AtividadeManager.sharedInstance.atualizaAtividade(novaAtividade)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func datePickerAction(sender: AnyObject) {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        var data = dateFormatter.stringFromDate(datePicker.date)
        self.dataEntrega.text = data
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nomeAvaliacao.resignFirstResponder()
        notaAvaliacao.resignFirstResponder()
        return true
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
        tipoAvaliacao.text = tiposDeAvaliacoes[row]
    }

}
