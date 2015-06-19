//
//  AvaliacaoViewController.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/18/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class AvaliacaoViewController: UIViewController {

    var atividade : Atividade?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = atividade?.nome
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
