//
//  BPUtility.swift
//  Benepicker
//
//  Created by 1002719 on 2016. 12. 5..
//  Copyright © 2016년 closer27. All rights reserved.
//

import Foundation

func dateFrom(MMddHHmm: String) -> Date? {
    // add year
    let dateString = "\(MMddHHmm) \(thisYear())"
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd HH:mm yyyy"
    dateFormatter.locale = Locale(identifier: "ko_kr")
    dateFormatter.timeZone = TimeZone(identifier: "KST")
    let date = dateFormatter.date(from: dateString)
    
    return date
}

func thisYear() -> Int {
    let calendar = Calendar.current
    return calendar.component(.year, from: Date())
}
