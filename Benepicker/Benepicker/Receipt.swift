//
//  Receipt.swift
//  Benepicker
//
//  Created by closer27 on 2016. 11. 13..
//  Copyright © 2016년 closer27. All rights reserved.
//

import Foundation

class Receipt {
    let card: String?
    let name: String?
    let date: String?
    let spend: String?
    let usedPlace: String?
    let accumulated: String?
    
    init(_ receiptDict: Dictionary<String, String>?) {
        self.card = receiptDict?["card"]
        self.name = receiptDict?["name"]
        self.date = receiptDict?["date"]
        self.spend = receiptDict?["spend"]
        self.usedPlace = receiptDict?["usedPlace"]
        self.accumulated = receiptDict?["accumulated"]
    }
    
    var description:String {
        get {
            return "Receipt object:\nCard: \(card)\nName: \(name)\nDate: \(date)\nSpend: \(spend)\nUsedPlace: \(usedPlace)\nAccumlated: \(accumulated)\n"
        }
    }
}
