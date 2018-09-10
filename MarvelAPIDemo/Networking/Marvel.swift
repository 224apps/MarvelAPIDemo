//
//  Marvel.swift
//  MarvelAPIDemo
//
//  Created by Abdoulaye Diallo on 9/10/18.
//  Copyright © 2018 224Apps. All rights reserved.
//

import Foundation
import Moya

public enum Marvel {
    static let privateKey = ""
    static let publicKey = ""
    case comics
}

extension Marvel: TargetType {
    
    public var baseURL: URL {
        return URL(string: "https://gateway.marvel.com/v1/public")!
    }
    public var path: String {
        switch self {
        case .comics: return "/comics"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .comics: return .get
        }
    }
    public var sampleData: Data {
        return Data()
    }
    public var task: Task {
        let ts = "\(Date().timeIntervalSince1970)"
        let hash = (ts + Marvel.privateKey + Marvel.publicKey).md5
        let authParams = ["apikey": Marvel.publicKey, "ts": ts, "hash": hash]
        switch self {
        case .comics:
            return .requestParameters(
                parameters: [
                    "format": "comic",
                    "formatType": "comic",
                    "orderBy": "-onsaleDate",
                    "dateDescriptor": "lastWeek",
                    "limit": 5] + authParams,
                encoding: URLEncoding.default)
        }
    }
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    public var validationType: ValidationType {
        return .successCodes
    }
}
