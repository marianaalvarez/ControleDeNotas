//
//  NovaDisciplinaTableViewController.swift
//  SemNome
//
//  Created by Mariana Alvarez on 15/06/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class NovaDisciplinaTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var nomeDisciplina: UITextField!
    @IBOutlet weak var semestreDisciplina: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nomeDisciplina.delegate = self
        semestreDisciplina.delegate = self
        semestreDisciplina.keyboardType = .NumberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        nomeDisciplina.resignFirstResponder()
        semestreDisciplina.resignFirstResponder()
    }

    @IBAction func salvaDisciplina(sender: AnyObject) {
        if nomeDisciplina.text.isEmpty {
            var alert = UIAlertController(title: "Nome em Branco",
                message: "É necessário fornecer um nome para a disciplina.",
                preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Ok",
                style: .Default) { (action: UIAlertAction!) -> Void in
            }
            
            alert.addAction(cancelAction)
            
            presentViewController(alert,
                animated: true,
                completion: nil)
        } else {
            var disciplina = DisciplinaManager.sharedInstance.novaDisciplina()
            disciplina.nome = nomeDisciplina.text
            disciplina.semestre = NSNumber(integer: semestreDisciplina.text.toInt()!)
            DisciplinaManager.sharedInstance.salvar()
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

}
