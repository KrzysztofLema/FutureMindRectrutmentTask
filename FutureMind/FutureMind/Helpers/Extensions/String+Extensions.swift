//
//  String+Extensions.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 11/04/2022.
//

import Foundation

extension String {
    func removingUrls() -> String {
        guard let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else {
            return self
        }
        return detector.stringByReplacingMatches(in: self,
                                                 options: [],
                                                 range: NSRange(location: 0, length: self.utf16.count),
                                                 withTemplate: "")
    }
}
