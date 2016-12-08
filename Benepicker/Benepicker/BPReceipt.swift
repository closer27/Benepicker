//
//  Receipt.swift
//  Benepicker
//
//  Created by closer27 on 2016. 11. 13..
//  Copyright © 2016년 closer27. All rights reserved.
//

import Foundation

enum BPReceiptError: Error {
    case InvalidSpend
    case InvalidDate
    case InvalidUsedPlace
}

class BPReceipt {
    var card: String?
    var name: String?
    var date: Date
    var spend: Decimal
    var usedPlace: String
    
    init(_ receiptDict: Dictionary<String, String>) throws {
        guard let dateString = receiptDict["date"] else {
            throw BPReceiptError.InvalidDate
        }
        
        guard let spendString = receiptDict["spend"] else {
            throw BPReceiptError.InvalidSpend
        }
        
        guard let usedPlaceString = receiptDict["usedPlace"] else {
            throw BPReceiptError.InvalidUsedPlace
        }

        let isInvalid = usedPlaceString.characters.contains{"\n".characters.contains($0)}
        if isInvalid {
            throw BPReceiptError.InvalidUsedPlace
        }
        
        if let date = dateFrom(MMddHHmm: dateString) {
            self.date = date
        } else {
            throw BPReceiptError.InvalidSpend
        }
        if let spend = decimalFrom(string: spendString) {
            self.spend = spend
        } else {
            throw BPReceiptError.InvalidSpend
        }
        
        self.usedPlace = usedPlaceString
        
        self.card = receiptDict["card"]
        self.name = receiptDict["name"]
    }
    
    var description:String {
        get {
            return "Receipt object:\nCard: \(card)\nName: \(name)\nDate: \(date)\nSpend: \(spend)\nUsedPlace: \(usedPlace)\n"
        }
    }
}
