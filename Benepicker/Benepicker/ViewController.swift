//
//  ViewController.swift
//  Benepicker
//
//  Created by closer27 on 2016. 11. 10..
//  Copyright © 2016년 closer27. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!

    let receiptParser: ReceiptParser = ReceiptParser.init()
    var receipts: [Receipt] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pasteMessages(_ sender: Any) {
        if UIPasteboard.general.hasStrings, let receiptMessages = UIPasteboard.general.strings {
            receipts = receiptParser.receiptsFromString(receiptMessages[0])
            tableView.reloadData()
        }
    }

    /* TableView DataSource */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receipts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReceiptTableViewCell = tableView.dequeueReusableCell(withIdentifier: "receiptCellIdentifier",
                for: indexPath) as! ReceiptTableViewCell
        let row = indexPath.row;

        let receipt: Receipt = receipts[row]
        cell.spendLabel.text = receipt.spend
        cell.dateLabel.text = receipt.date
        cell.usedPlaceLabel.text = receipt.usedPlace

        return cell
    }

    /* TableView Delegate */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}

