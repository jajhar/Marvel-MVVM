//
//  Comic.swift
//  Marvel
//
//  Created by Julia Ajhar on 2/12/24.
//

import Foundation

protocol ComicProtocol {
    var id: Int { get }
    var title: String { get }
    var description: String { get }
    var images: [Image] { get }
}

struct Comic: ComicProtocol, Codable {
    let id: Int
    let title: String
    let description: String
    let images: [Image]
}
