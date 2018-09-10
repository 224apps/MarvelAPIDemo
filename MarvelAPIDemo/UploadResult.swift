//
//  UploadResult.swift
//  MarvelAPIDemo
//
//  Created by Abdoulaye Diallo on 9/10/18.
//  Copyright © 2018 224Apps. All rights reserved.
//

import Foundation

struct UploadResult:Codable, CustomDebugStringConvertible {
    let deletehash:String
    let link:URL
    var debugDescription: String {
        return "<UploadResult: \(deletehash)>\(link)"
    }
}
