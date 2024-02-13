//
//  Image.swift
//  Marvel
//
//  Created by Julia Ajhar on 2/12/24.
//

import Foundation

protocol ImageProtocol {
    var path: String { get }
    var ext: String { get }
    var url: URL? { get }
}

struct Image: ImageProtocol, Codable {
    let path: String
    let ext: String
    
    var url: URL? {
        URL(string: "\(path).\(ext)")
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
