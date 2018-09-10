//
//  CodableResponses.swift
//  MarvelAPIDemo
//
//  Created by Abdoulaye Diallo on 9/10/18.
//  Copyright © 2018 224Apps. All rights reserved.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    let data: MarvelResults<T>
}

struct MarvelResults<T: Codable>: Codable {
    let results: [T]
}

struct ImgurResponse<T: Codable>: Codable {
    let data: T
}
