//
//  ReceiptParser.swift
//  Benepicker
//
//  Created by closer27 on 2016. 11. 19..
//  Copyright © 2016년 closer27. All rights reserved.
//

import Foundation

class BPReceiptParser {
    func receiptsFromString(_ receiptRawMessage: String) -> [BPReceipt] {
        // extract each receiptMessage from receiptRawMessage
        let extractedReceiptMessages: [String] = self.extractReceipt(receiptRawMessage)
        
        // the list for Receipt objects
        var receipts: [BPReceipt] = []
        
        // process each receipt as Receipt object
        for receiptMessage in extractedReceiptMessages {
            // get details from receiptMessage
            let receiptDetails:[String] = self.extractDetail(receiptMessage)
            
            // classify details to dictionary
            let receiptDict:Dictionary = self.classifyReceipt(receiptDetails)
            
            // make new Receipt object
            let receiptObject:BPReceipt? = try? BPReceipt.init(receiptDict)
            
            // push the object to the list if exists
            if let aReceiptObject = receiptObject {
                receipts.append(aReceiptObject)
            }
        }
        return receipts
    }
    
    // Private methods
    private func extractReceipt(_ receiptString: String) -> [String] {
        return receiptString.components(separatedBy: "[Web발신]\n").filter({ (receipt) -> Bool in
            !receipt.isEmpty
        })
    }
    
    private func extractDetail(_ receiptString: String) -> [String] {
        return receiptString.characters.split{$0 == "\n"}.map(String.init)
    }
    
    private func classifyReceipt(_ receiptItems: [String]) -> Dictionary<String, String> {
        let cardPattern: String = "^KB국민(카드|체크)\\s*(\\d\\*\\d\\*)?$"
        let namePattern: String = "^\\S{0,}님$"
        let datePattern: String = "^\\d{2}/\\d{2} \\d{2}:\\d{2}$"
        let spendPattern: String = "^[0-9]{1,3}(,[0-9]{3})*(.[0-9]{1,2})?(원|\\(US\\$\\))$"
        let accumulatedPattern: String = "^(누적|잔여)\\s[0-9]{1,3}(,[0-9]{3})*(.[0-9]{1,2})?(원|\\(US\\$\\))$"
        
        var receiptDict: Dictionary<String, String> = Dictionary.init()
        for item in receiptItems {
            if item =~ cardPattern {
                receiptDict["card"] = item
            } else if item =~ namePattern {
                receiptDict["name"] = item
            } else if item =~ datePattern {
                receiptDict["date"] = item
            } else if item =~ spendPattern {
                receiptDict["spend"] = item
            } else if item =~ accumulatedPattern {
                receiptDict["accumulated"] = item
            } else {
                receiptDict["usedPlace"] = item
            }
        }
        
        return receiptDict
    }
}
