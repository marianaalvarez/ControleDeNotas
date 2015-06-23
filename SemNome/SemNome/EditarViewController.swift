//
//  EditarViewController.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/23/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class EditarViewController: UIViewController, UITextFieldDelegate {

    var atividade: Atividade?
    
    @IBOutlet weak var disciplinaTextField: UITextField!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var tipoLabel: UILabel!
    @IBOutlet weak var notaTextField: UITextField!
    var data : NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        disciplinaTextField.delegate = self
        notaTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        disciplinaTextField.placeholder = atividade?.nome
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dataLabel.text = dateFormatter.stringFromDate(atividade!.dia)
        data = atividade?.dia
        
        if atividade?.tipo == 0 {
            tipoLabel.text = "Trabalho"
        } else {
            tipoLabel.text = "Prova"
        }
        
        notaTextField.placeholder = "\(atividade!.nota)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        disciplinaTextField.resignFirstResponder()
        notaTextField.resignFirstResponder()
        return true
    }

    @IBAction func salvar(sender: UIBarButtonItem) {
        if !disciplinaTextField.text.isEmpty {
            atividade?.nome = disciplinaTextField.text
        }
        
        if !notaTextField.text.isEmpty {
            var stringNota = notaTextField.text.stringByReplacingOccurrencesOfString(".", withString: ",", options: .LiteralSearch, range: nil)
            atividade?.nota = NSNumberFormatter().numberFromString(stringNota)!
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
