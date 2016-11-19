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
        
        let receiptRawMessages: String = "[Web발신]\n" +
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
        
        let receiptParser:ReceiptParser = ReceiptParser.init()
        let receipts:[Receipt] = receiptParser.receiptsFromString(receiptRawMessages)
        for receipt in receipts {
            print(receipt.description)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

