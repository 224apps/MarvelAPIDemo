//
//  Extension.swift
//  MarvelAPIDemo
//
//  Created by Abdoulaye Diallo on 9/10/18.
//  Copyright © 2018 224Apps. All rights reserved.
//

import Foundation

extension String {
    var md5: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        if let data = data(using: String.Encoding.utf8) {
            _ = data.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(data.count), &digest)
            }
        }
        
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}

extension Date {
    init?(ISO8601: String) {
        let isoFormatter = ISO8601DateFormatter()
        
        guard let date = isoFormatter.date(from: ISO8601) else { return nil }
        self = date
    }
}



public func + <KeyType, ValueType> (left: [KeyType: ValueType], right: [KeyType: ValueType]) -> [KeyType: ValueType] {
    var out = left
    
    for (k, v) in right {
        out.updateValue(v, forKey: k)
    }
    return out
}
