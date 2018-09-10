//
//  Comic.swift
//  MarvelAPIDemo
//
//  Created by Abdoulaye Diallo on 9/10/18.
//  Copyright © 2018 224Apps. All rights reserved.
//

import Foundation

struct Comic: Codable {
    let id: Int
    let title: String
    let description: String?
    let thumbnail: Thumbnail
    let characters: CharactersInfo
    private let dates: [Date]
    
    public var onsaleDate: Foundation.Date {
        guard let stringDate = dates.first(where: { $0.type == "onsaleDate" })?.date,
            let date = Foundation.Date(ISO8601: stringDate) else {
                fatalError("onsaleDate must be present for a Comics object: \(dates)")
        }
        
        return date
    }
}

extension Comic: CustomDebugStringConvertible {
    var debugDescription: String {
        return "<Comic:\(id)> \(title) with \(dates.count) dates and \(characters.available) characters on-sale from \(onsaleDate)"
    }
}

extension Comic {
    //Thumbnail
    struct Thumbnail: Codable {
        let path: String
        let `extension`: String
        
        var url: URL {
            return URL(string: path + "." + `extension`)!
        }
    }
    // Date
    struct Date: Codable {
        let type: String
        let date: String
    }

    // CharactersInfo
    struct CharactersInfo: Codable {
        let available: Int
        let items: [Character]
    }
    
    //Characters
    struct Character: Codable {
        let resourceURI: URL
        let name: String
    }
}
