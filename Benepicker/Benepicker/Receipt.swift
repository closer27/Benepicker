//
//  Receipt.swift
//  Benepicker
//
//  Created by closer27 on 2016. 11. 13..
//  Copyright © 2016년 closer27. All rights reserved.
//

import Foundation

enum ReceiptError: Error {
    case InvalidSpend
    case InvalidDate
    case InvalidUsedPlace
}

class Receipt {
    var card: String?
    var name: String?
    var date: String?
    var spend: String?
    var usedPlace: String?
    var accumulated: String?
    
    init(_ receiptDict: Dictionary<String, String>) throws {
        guard let date = receiptDict["date"] else {
            throw ReceiptError.InvalidDate
        }
        
        guard let spend = receiptDict["spend"] else {
            throw ReceiptError.InvalidSpend
        }
        
        guard let usedPlace = receiptDict["usedPlace"] else {
            throw ReceiptError.InvalidUsedPlace
        }

        let isInvalid = usedPlace.characters.contains{"\n".characters.contains($0)}
        if isInvalid {
            throw ReceiptError.InvalidUsedPlace
        }
        
        self.date = date
        self.spend = spend
        self.usedPlace = usedPlace
        
        self.card = receiptDict["card"]
        self.name = receiptDict["name"]
        
        self.accumulated = receiptDict["accumulated"]
    }
    
    var description:String {
        get {
            return "Receipt object:\nCard: \(card)\nName: \(name)\nDate: \(date)\nSpend: \(spend)\nUsedPlace: \(usedPlace)\nAccumlated: \(accumulated)\n"
        }
    }
}
