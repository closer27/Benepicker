//
//  BPRegex.swift
//  Benepicker
//
//  Created by closer27 on 2016. 11. 13..
//  Copyright © 2016년 closer27. All rights reserved.
//

import Foundation

infix operator =~

class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) {
        self.pattern = pattern
        self.internalExpression = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func test(input: String) -> Bool {
        let matches = self.internalExpression.matches(in: input, options: [], range: NSMakeRange(0, input.characters.count))
        return matches.count > 0
    }
}

func =~ (input: String, pattern: String) -> Bool {
    return Regex(pattern).test(input: input)
}
