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
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testReceiptCount() {
        let receipts = receiptParser.receiptsFromString(oneMessage)
        XCTAssertEqual(receipts.count, 1, "receipt count is 1")
    }
    
    func testReceiptValid() {
        let receipts = receiptParser.receiptsFromString(oneMessage)
        XCTAssertNotNil(receipts[0], "receipt is not nil")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
