//
//  String+Extensions.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 11/04/2022.
//

import Foundation

extension String {
    func removingUrls() -> String {
        guard let detector = try? NSDataDetector(
            types: NSTextCheckingResult.CheckingType.link.rawValue
        ) else {
            return self
        }
        return detector.stringByReplacingMatches(in: self,
                                                 options: [],
                                                 range: NSRange(location: 0, length: self.utf16.count),
                                                 withTemplate: "")
    }

    func detectUrl() -> String {
        guard let detector = try? NSDataDetector(
            types: NSTextCheckingResult.CheckingType.link.rawValue
        ) else {
            return ""
        }
        let matches = detector.matches(
            in: self,
            options: [],
            range: NSRange(location: 0,length: self.utf16.count)
        )

        for match in matches {
            guard let range = Range(match.range, in: self) else { continue }
            let url = self[range]
            return String(url)
        }
        return ""
    }

    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)
        let formattedDate = date?.formatted(date: .complete, time: .omitted)
        return formattedDate ?? self
    }
}
