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
        
        for i in 0...7 {
            var calendar = NSCalendar.currentCalendar()
            var components = calendar.components(NSCalendarUnit.YearCalendarUnit|NSCalendarUnit.MonthCalendarUnit|NSCalendarUnit.DayCalendarUnit|NSCalendarUnit.HourCalendarUnit|NSCalendarUnit.MinuteCalendarUnit, fromDate: atividade.dia)
            components.day -= i
            
            var novaData = calendar.dateFromComponents(components)
            
            var notification = UILocalNotification()
            
            if i == 0 {
                notification.alertBody = "A entrega da atividade \(atividade.nome) da disciplina \(atividade.disciplina.nome) é hoje!"
            } else if i == 1 {
                notification.alertBody = "A entrega da atividade \(atividade.nome) da disciplina \(atividade.disciplina.nome) é amanhã!"
            } else {
                notification.alertBody = "Faltam \(i) dias para a entrega da atividade \(atividade.nome) da disciplina \(atividade.disciplina.nome)."
            }
            notification.fireDate = novaData
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.userInfo = ["disciplina": atividade.disciplina.nome, "atividade": atividade.nome]
            notification.category = "ANOTAI_CATEGORY"
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            println(notification.userInfo!["atividade"]!)
        }
    }
}
