//
//  NovaAvaliacaoViewController.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/24/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class NovaAvaliacaoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var disciplina: Disciplina?
    var nomeExistente = false
    var data : NSDate?
    let tiposDeAvaliacoes = ["Prova","Trabalho"]
    
    @IBOutlet weak var nomeTextField: UITextField!
    @IBOutlet weak var pesoTextField: UITextField!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var tipoLabel: UILabel!
    @IBOutlet weak var datePickerSubView: UIView!
    @IBOutlet weak var pickerViewSubView: UIView!
    @IBOutlet weak var botaoSelecionar: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pickerView: UIPickerView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        botaoSelecionar.alpha = 0
        
        datePickerSubView.hidden = true
        pickerViewSubView.hidden = true
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        nomeTextField.delegate = self
        pesoTextField.delegate = self
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dataLabel.text = dateFormatter.stringFromDate(datePicker.date)
        
        tipoLabel.text = "Prova"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        nomeTextField.resignFirstResponder()
        pesoTextField.resignFirstResponder()
    }
    
    @IBAction func alterarData(sender: UIButton) {
        botaoSelecionar.alpha = 1
        datePickerSubView.hidden = false
        pickerViewSubView.hidden = true
    }

    @IBAction func alterarTipo(sender: UIButton) {
        botaoSelecionar.alpha = 1
        pickerViewSubView.hidden = false
        datePickerSubView.hidden = true
    }
    
    @IBAction func selecionar(sender: UIButton) {
        botaoSelecionar.alpha = 0
        pickerViewSubView.hidden = true
        datePickerSubView.hidden = true
    }
    
    @IBAction func salvar(sender: UIBarButtonItem) {
        nomeExistente = false
        if nomeTextField.text.isEmpty {
            var alert = UIAlertController(title: "Nome em Branco",
                message: "É necessário fornecer um nome para a atividade.",
                preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Ok",
                style: .Default) { (action: UIAlertAction!) -> Void in
            }
            
            alert.addAction(cancelAction)
            
            presentViewController(alert,animated: true,completion: nil)
        } else {
            var atividades = disciplina?.atividades.allObjects as! [Atividade]
            for atividade in atividades {
                if atividade.nome == nomeTextField.text {
                    var alert = UIAlertController(title: "Atenção", message: "Nome da atividade já existe para essa disciplina!", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    nomeExistente = true
                }
            }
            if (!nomeExistente) {
                var atividade = AtividadeManager.sharedInstance.novaAtividade()
                atividade.nome = nomeTextField.text
                atividade.dia = datePicker.date
                if tipoLabel.text == "Trabalho" {
                    atividade.tipo = 0
                } else {
                    atividade.tipo = 1
                }
                atividade.disciplina = disciplina!
                atividade.notificacao = 1
                if pesoTextField.text.isEmpty {
                    atividade.peso = 1
                } else {
                    var stringPeso = pesoTextField.text.stringByReplacingOccurrencesOfString(".", withString: ",", options: .LiteralSearch, range: nil)
                    atividade.peso = NSNumberFormatter().numberFromString(stringPeso)!
                }
                AtividadeManager.sharedInstance.salvar()
                
                LocalNotificationManager.sharedInstance.criaNotificacao(atividade)
                
                self.navigationController?.popViewControllerAnimated(true)
            }
        }

    }
    
    @IBAction func mudarValorDatePicker(sender: UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dataLabel.text = dateFormatter.stringFromDate(datePicker.date)
        data = datePicker.date
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
    
}
