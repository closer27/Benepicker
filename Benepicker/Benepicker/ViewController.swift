//
//  ViewController.swift
//  Benepicker
//
//  Created by closer27 on 2016. 11. 10..
//  Copyright © 2016년 closer27. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var tableView: UITableView!

    let receiptParser: ReceiptParser = ReceiptParser.init()
    var receipts = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Receipt")
        
        // 3
        do {
            let results = try managedContext.fetch(fetchRequest)
            receipts = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pasteMessages(_ sender: Any) {
        if UIPasteboard.general.hasStrings, let receiptMessages = UIPasteboard.general.strings {
            let receiptObjects: [ReceiptObject] = receiptParser.receiptsFromString(receiptMessages[0])
            self.saveData(receiptObjects)
            tableView.reloadData()
        }
    }
    
    func saveData(_ receiptObjects:[ReceiptObject]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Receipt", in: managedContext)
        
        for aReceipt in receiptObjects {
            let receipt = NSManagedObject(entity: entity!, insertInto: managedContext)
            receipt.setValue(aReceipt.card, forKey: "card")
            receipt.setValue(aReceipt.name, forKey: "name")
            receipt.setValue(aReceipt.spend, forKey: "spend")
            receipt.setValue(aReceipt.usedPlace, forKey: "usedPlace")
            receipt.setValue(aReceipt.accumulated, forKey: "accumulated")
            
            do {
                try managedContext.save()
                receipts.append(receipt)
            } catch let error as NSError {
                print("Could not save \(error), \(error.userInfo)")
            }
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

        let receipt = receipts[row]
        cell.spendLabel.text = receipt.value(forKey: "spend") as? String
//        cell.dateLabel.text = receipt.value(forKey: "date")
        cell.usedPlaceLabel.text = receipt.value(forKey: "usedPlace") as? String

        return cell
    }

    /* TableView Delegate */
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 58
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }

}

