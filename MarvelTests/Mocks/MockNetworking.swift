//
//  MockNetworking.swift
//  MarvelTests
//
//  Created by Julia Ajhar on 2/12/24.
//

import Foundation

struct MockNetworking {
    
    var urlSession: URLSession {
        let configuration: URLSessionConfiguration = .ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }
}
