//
//  EditarViewController.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/23/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class EditarViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var atividade: Atividade?
    var data : NSDate?
    let tiposDeAvaliacoes = ["Trabalho","Prova"]
    
    @IBOutlet weak var disciplinaTextField: UITextField!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var tipoLabel: UILabel!
    @IBOutlet weak var notaTextField: UITextField!
    @IBOutlet weak var selecionarBotao: UIButton!
    @IBOutlet weak var pesoTextField: UITextField!

    @IBOutlet weak var datePickerSubView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var pickerViewSubView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selecionarBotao.alpha = 0
        
        datePickerSubView.hidden = true
        pickerViewSubView.hidden = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        disciplinaTextField.delegate = self
        notaTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        disciplinaTextField.text = atividade?.nome
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dataLabel.text = dateFormatter.stringFromDate(atividade!.dia)
        data = atividade?.dia
        
        if atividade?.tipo == 0 {
            tipoLabel.text = "Trabalho"
        } else {
            tipoLabel.text = "Prova"
        }
        
        notaTextField.text = "\(atividade!.nota)"
        
        pesoTextField.text = "\(atividade!.peso)"
        if atividade?.tipo == 0 {
            pickerView.selectRow(0, inComponent: 0, animated: true)
        } else {
            pickerView.selectRow(1, inComponent: 0, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        disciplinaTextField.resignFirstResponder()
        notaTextField.resignFirstResponder()
    }
    
    @IBAction func alterarData(sender: UIButton) {
        selecionarBotao.alpha = 1
        datePickerSubView.hidden = false
        pickerViewSubView.hidden = true
    }
    
    @IBAction func alterarTipo(sender: UIButton) {
        selecionarBotao.alpha = 1
        pickerViewSubView.hidden = false
        datePickerSubView.hidden = true
        tipoLabel.text = "Prova"
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
        tipoLabel.text = tiposDeAvaliacoes[row]
    }
    
    // DatePicker action
    @IBAction func mudarValorDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dataLabel.text = dateFormatter.stringFromDate(datePicker.date)
        data = datePicker.date
    }
    
    @IBAction func acaoSelecionar(sender: UIButton) {
        selecionarBotao.alpha = 0
        pickerViewSubView.hidden = true
        datePickerSubView.hidden = true
    }
    
    @IBAction func salvar(sender: UIBarButtonItem) {
        if !disciplinaTextField.text.isEmpty {
            atividade?.nome = disciplinaTextField.text
        }
        
        if !notaTextField.text.isEmpty {
            var stringNota = notaTextField.text.stringByReplacingOccurrencesOfString(".", withString: ",", options: .LiteralSearch, range: nil)
            atividade?.nota = NSNumberFormatter().numberFromString(stringNota)!
        }
        
        if !pesoTextField.text.isEmpty {
            var stringPeso = pesoTextField.text.stringByReplacingOccurrencesOfString(".", withString: ",", options: .LiteralSearch, range: nil)
            atividade?.peso = NSNumberFormatter().numberFromString(stringPeso)!
        }
        
        if tipoLabel.text == "Trabalho" {
            atividade!.tipo = 0
        } else {
            atividade!.tipo = 1
        }
        
        atividade?.dia = data!
        
        AtividadeManager.sharedInstance.salvar()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
