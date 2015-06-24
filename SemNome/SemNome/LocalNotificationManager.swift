//
//  LocalNotificationManager.swift
//  SemNome
//
//  Created by Mariana Alvarez on 23/06/15.
//  Copyright (c) 2015 Mariana Alvarez. All rights reserved.
//

import UIKit

class LocalNotificationManager {
    
    static let sharedInstance = LocalNotificationManager()
    
    private init(){}
    
    func criaNotificacao(atividade: Atividade) {
        
        var calendar = NSCalendar.currentCalendar()
        var components = calendar.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitDay | .CalendarUnitHour | .CalendarUnitMinute, fromDate: atividade.dia)
        
        components.day = components.day - 1
            
        var novaData = calendar.dateFromComponents(components)
            
        var notification = UILocalNotification()
        notification.alertBody = "A entrega da atividade \(atividade.nome) da disciplina \(atividade.disciplina.nome) é amanhã!"
        notification.fireDate = novaData
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["disciplina": atividade.disciplina.nome, "atividade": atividade.nome]
        notification.category = "ANOTAI_CATEGORY"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
    }
}
