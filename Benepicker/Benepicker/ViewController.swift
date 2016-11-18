//
//  ViewController.swift
//  Benepicker
//
//  Created by closer27 on 2016. 11. 10..
//  Copyright © 2016년 closer27. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let receiptBunch: String = "[Web발신]\n" +
        "KB국민카드 4*6*\n" +
        "김*원님\n" +
        "11/03 09:29\n" +
        "3,300원\n" +
        "스타벅스커피코\n" +
        "누적 490,040원\n" +
        "[Web발신]\n" +
        "KB국민카드 4*6*\n" +
        "김*원님\n" +
        "11/02 23:32\n" +
        "1,700원\n" +
        "세븐일레븐 안양\n" +
        "누적 486,740원\n"
//        "2.19(US$)\n"
        
        let receipts: [String] = self.extractReceipt(receiptBunch)
        let aReceipt = receipts[0]
        
        let items: [String] = self.extractDetail(aReceipt)
        
        let postedPattern: String = "\\[\\S{0,}\\]"
        let cardPattern: String = "^KB국민(카드|체크)\\s*(\\d\\*\\d\\*)?$"
        let namePattern: String = "^\\S{0,}님$"
        let datePattern: String = "^\\d{2}/\\d{2} \\d{2}:\\d{2}$"
        let spendPattern: String = "^[0-9]{1,3}(,[0-9]{3})*(.[0-9]{1,2})?(원|\\(US\\$\\))$"
        let totalSpendPattern: String = "^누적\\s[0-9]{1,3}(,[0-9]{3})*(.[0-9]{1,2})?(원|\\(US\\$\\))$"
        
        for item in items {
            if item =~ postedPattern {
                print("\(item) is posted")
            } else if item =~ cardPattern {
                print("\(item) is card")
            } else if item =~ namePattern {
                print("\(item) is name")
            } else if item =~ datePattern {
                print("\(item) is date")
            } else if item =~ spendPattern {
                print("\(item) is spend")
            } else if item =~ totalSpendPattern {
                print("\(item) is totalSpend")
            } else {
                print("\(item) is usedPlace")
            }
        }
    }
    
    func extractReceipt(_ receiptString: String) -> [String] {
        return receiptString.components(separatedBy: "[Web발신]\n").filter({ (receipt) -> Bool in
            !receipt.isEmpty
        })
    }

    func extractDetail(_ receiptString: String) -> [String] {
        return receiptString.characters.split{$0 == "\n"}.map(String.init)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

