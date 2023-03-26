//
//  NetworkLayer.swift
//  QooGlobalTask
//
//  Created by Ma7rous on 23/03/2023.
//

import Foundation
import Moya

public enum NetworkLayer {
    
    case players
    case playerDetails(playerSlug: String)
}

extension NetworkLayer: TargetType {
    public var baseURL: URL {
        return URL(string: "https://ios.app99877.com/api/sc/")!
    }
    
    public var path: String {
        switch self {
        case .players:
            return "players"
        case .playerDetails:
            return "player/details"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .players:
            return .get
        case .playerDetails:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .players:
            return .requestPlain
        case .playerDetails(let playerSlug):
            
            return .requestParameters(parameters: ["slug": playerSlug], encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
