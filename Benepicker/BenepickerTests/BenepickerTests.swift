//
//  BenepickerTests.swift
//  BenepickerTests
//
//  Created by closer27 on 2016. 11. 10..
//  Copyright © 2016년 closer27. All rights reserved.
//

import XCTest
@testable import Benepicker

class BenepickerTests: XCTestCase {
    var receiptParser:ReceiptParser!
    var oneMessage:String!
    var multipleMessage:String!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        receiptParser = ReceiptParser.init()
        oneMessage = "[Web발신]\n" +
            "KB국민카드 4*6*\n" +
            "김*원님\n" +
            "11/02 23:32\n" +
            "1,700원\n" +
            "세븐일레븐 안양\n" +
            "누적 486,740원\n"
        multipleMessage = "[Web발신]\n" +
            "KB국민카드 4*6*\n" +
            "김*원님\n" +
            "11/02 23:32\n" +
            "1,700원\n" +
            "세븐일레븐 안양\n" +
            "누적 486,740원\n" +
            "[Web발신]\n" +
            "KB국민카드 4*6*\n" +
            "김*원님\n" +
            "11/03 09:29\n" +
            "3,300원\n" +
            "스타벅스커피코\n" +
            "누적 490,040원\n"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    /* test one message */
    func testReceiptCount() {
        let receipts = receiptParser.receiptsFromString(oneMessage)
        XCTAssertEqual(receipts.count, 1, "receipt count is 1")
    }
    
    func testReceiptValid() {
        let receipts = receiptParser.receiptsFromString(oneMessage)
        XCTAssertNotNil(receipts[0], "receipt is not nil")
    }
    
    func testReceiptHistory() {
        let receipts = receiptParser.receiptsFromString(oneMessage)
        let aReceipt = receipts[0]
        XCTAssertEqual(aReceipt.card, "KB국민카드 4*6*", "card info is correct")
        XCTAssertEqual(aReceipt.name, "김*원님", "name is correct")
        XCTAssertEqual(aReceipt.date, "11/02 23:32", "date is correct")
        XCTAssertEqual(aReceipt.spend, "1,700원", "spend is correct")
        XCTAssertEqual(aReceipt.usedPlace, "세븐일레븐 안양", "usedPlace is correct")
        XCTAssertEqual(aReceipt.accumulated, "누적 486,740원", "accumulated is correct")
    }
    
    /* test multiple messages */
    func testMultipleReceiptCount() {
        let receipts = receiptParser.receiptsFromString(multipleMessage)
        XCTAssertEqual(receipts.count, 2, "receipt count is 2")
    }
    
    func testMultipleReceiptValid() {
        let receipts = receiptParser.receiptsFromString(multipleMessage)
        XCTAssertNotNil(receipts[0], "receipt 0 is not nil")
        XCTAssertNotNil(receipts[1], "receipt 1 is not nil")
    }
    
    func testMultipleReceiptHistory() {
        let receipts = receiptParser.receiptsFromString(multipleMessage)
        let secondReceipt = receipts[1]
        XCTAssertEqual(secondReceipt.card, "KB국민카드 4*6*", "card info is correct")
        XCTAssertEqual(secondReceipt.name, "김*원님", "name is correct")
        XCTAssertEqual(secondReceipt.date, "11/03 09:29", "date is correct")
        XCTAssertEqual(secondReceipt.spend, "3,300원", "spend is correct")
        XCTAssertEqual(secondReceipt.usedPlace, "스타벅스커피코", "usedPlace is correct")
        XCTAssertEqual(secondReceipt.accumulated, "누적 490,040원", "accumulated is correct")
    }
    
    /* other format */
    func testReceiptWithoutAccumulated() {
        let messageWithoutAccumulated = "[Web발신]\n" +
            "KB국민카드 4*6*\n" +
            "김*원님\n" +
            "11/02 23:32\n" +
            "1,700원\n" +
            "세븐일레븐 안양\n"
        let receipts = receiptParser.receiptsFromString(messageWithoutAccumulated)
        XCTAssertEqual(receipts.count, 1, "receipt count is 1")
        
        let aReceipt = receipts[0]
        XCTAssertEqual(aReceipt.card, "KB국민카드 4*6*", "card info is correct")
        XCTAssertEqual(aReceipt.name, "김*원님", "name is correct")
        XCTAssertEqual(aReceipt.date, "11/02 23:32", "date is correct")
        XCTAssertEqual(aReceipt.spend, "1,700원", "spend is correct")
        XCTAssertEqual(aReceipt.usedPlace, "세븐일레븐 안양", "usedPlace is correct")
        XCTAssertNil(aReceipt.accumulated, "accumulated is nil")
    }
    
    func testReceiptNotCreditButCheck() {
        let messageFromCheck = "[Web발신]\n" +
            "KB국민체크 2*4*\n" +
            "장*희님\n" +
            "10/15 03:51\n" +
            "4,800원\n" +
            "티머니 택시\n" +
            "잔여 231,000원"
        let receipts = receiptParser.receiptsFromString(messageFromCheck)
        XCTAssertEqual(receipts.count, 1, "receipt count is 1")
        
        let aReceipt = receipts[0]
        XCTAssertEqual(aReceipt.card, "KB국민체크 2*4*", "card info is correct")
        XCTAssertEqual(aReceipt.name, "장*희님", "name is correct")
        XCTAssertEqual(aReceipt.date, "10/15 03:51", "date is correct")
        XCTAssertEqual(aReceipt.spend, "4,800원", "spend is correct")
        XCTAssertEqual(aReceipt.usedPlace, "티머니 택시", "usedPlace is correct")
        XCTAssertEqual(aReceipt.accumulated, "잔여 231,000원", "accumulated is correct")
    }
    
    /* Invalid message */
    func testMessageWithInvalidSpend() {
        let messageWithoutSpend = "[Web발신]\n" +
            "KB국민카드 4*6*\n" +
            "김*원님\n" +
            "11/02 23:32\n" +
            "세븐일레븐 안양\n" +
            "누적 486,740원\n"
        let receipts = receiptParser.receiptsFromString(messageWithoutSpend)
        XCTAssertEqual(receipts.count, 0, "receipt count is 0")
    }
    
    func testMessageWithInvalidDate() {
        let messageWithoutSpend = "[Web발신]\n" +
            "KB국민카드 4*6*\n" +
            "김*원님\n" +
            "1,700원\n" +
            "세븐일레븐 안양\n" +
            "누적 486,740원\n"
        let receipts = receiptParser.receiptsFromString(messageWithoutSpend)
        XCTAssertEqual(receipts.count, 0, "receipt count is 0")
    }
    
    func testMessageWithInvalidUsedPlace() {
        let messageWithoutSpend = "[Web발신]\n" +
            "KB국민카드 4*6*\n" +
            "김*원님\n" +
            "11/02 23:32\n" +
            "1,700원\n" +
            "누적 486,740원\n"
        let receipts = receiptParser.receiptsFromString(messageWithoutSpend)
        XCTAssertEqual(receipts.count, 0, "receipt count is 0")
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
