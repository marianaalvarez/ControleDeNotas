//
//  InicioViewController.swift
//  SemNome
//
//  Created by Guilherme Bayma on 6/19/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit
import EventKit

class InicioViewController: UIViewController {

    var eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        eventStore.requestAccessToEntityType(EKEntityTypeReminder,
            completion: { (granted: Bool, error: NSError!) in
                if !granted {
                    println("Access to store not granted")
                }
                self.proximaView()
            })
    }
    
    func proximaView() {
        performSegueWithIdentifier("segueInicial", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
