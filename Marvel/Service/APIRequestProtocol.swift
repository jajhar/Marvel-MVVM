//
//  APIRequestProtocol.swift
//  Marvel
//
//  Created by Julia Ajhar on 2/12/24.
//

import CryptoKit
import Foundation

protocol APIRequestProtocol {
    
    static var baseURL: URL { get }
    static var apiVersion: String { get }
    static var publicApiKey: String { get }
    static var privateApiKey: String { get }

    var methodType: RequestType { get }
    var path: String { get }
}

extension APIRequestProtocol {
    
    func request() -> URLRequest? {
        guard let path = path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed),
            var url = URL(string: "\(Self.baseURL)/\(Self.apiVersion)\(path)") else {
            print("\(#function): Invalid URL: \(Self.baseURL)/\(Self.apiVersion)\(path)")
                return nil
        }
        
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = generateHash(timestamp: timestamp)
        
        url.append(queryItems: [
            .init(name: "ts", value: timestamp),
            .init(name: "hash", value: hash),
            .init(name: "apikey", value: Self.publicApiKey)
        ])
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = methodType.rawValue
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request as URLRequest
    }
    
    func generateHash(timestamp: String) -> String {
        return (timestamp + Self.privateApiKey + Self.publicApiKey).md5
    }
}

private extension String {
    var md5: String {
        Insecure.MD5
            .hash(data: self.data(using: .utf8)!)
            .map {String(format: "%02x", $0)}
            .joined()
    }
}
