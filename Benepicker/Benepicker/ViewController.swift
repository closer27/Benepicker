//
//  ViewController.swift
//  Benepicker
//
//  Created by 1002719 on 2016. 11. 10..
//  Copyright © 2016년 closer27. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let receiption: String = "[Web발신]\n" +
        "KB국민카드 4*6*\n" +
        "김*원님\n" +
        "11/03 09:29\n" +
        "3,300원\n" +
        "스타벅스커피코\n" +
        "누적 490,040원\n"
        
        let items: [String] = receiption.characters.split{$0 == "\n"}.map(String.init)
        let datePattern: String = "\\d{2}/\\d{2} \\d{2}:\\d{2}"
        for item in items {
            if item =~ datePattern {
                print("\(item) is date")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

