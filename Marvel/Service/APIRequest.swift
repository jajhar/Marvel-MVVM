//
//  APIRequest.swift
//  Marvel
//
//  Created by Julia Ajhar on 2/12/24.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum APIRequest: APIRequestProtocol {
    
    // Force unwrap here because we want it to hard crash immediately if this url is nil
    static let baseURL: URL = URL(string: "https://gateway.marvel.com")!
    
    /// Public developer.marvel.com key
    static let publicApiKey: String = "dea18b763c12cd2f6c1997a257a49da6"
    
    /// FOR DEMO PURPOSES ONLY - NEVER DO THIS IN A LIVE APP
    static let privateApiKey: String = "<ask_for_key>"
    
    /// Version of the API to use
    static let apiVersion: String = "v1"
    
    // Fetch comic info from id
    case fetchComic(comicId: Int)

    var methodType: RequestType {
        switch self {
        case .fetchComic:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .fetchComic(let comicId):
            return "/public/comics/\(comicId)"
        }
    }
    
}
