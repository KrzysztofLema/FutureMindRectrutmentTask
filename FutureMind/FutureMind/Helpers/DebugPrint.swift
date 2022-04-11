//
//  DebugPrint.swift
//  FutureMind
//
//  Created by Krzysztof Lema on 11/04/2022.
//

import Foundation

fileprivate func debugPrint(_ item: Any) {
    #if DEBUG
    print("[\(Date())] \(item)")
    #endif
}

public func debugError(_ item: Any) {
    let newItems = "[❌] -> \(item)"
    debugPrint(newItems)
}

public func debugWarning(_ item: Any) {
    let newItems = "[⚠️] -> \(item)"
    debugPrint(newItems)
}

public func debugInfo(_ item: Any) {
    let newItems = "[ℹ️] -> \(item)"
    debugPrint(newItems)
}

public func debugSuccess(_ item: Any) {
    let newItems = "[✅] -> \(item)"
    debugPrint(newItems)
}
