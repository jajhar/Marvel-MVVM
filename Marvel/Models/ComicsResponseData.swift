//
//  ComicsResponseData.swift
//  Marvel
//
//  Created by Julia Ajhar on 2/12/24.
//

import Foundation

protocol ComicsResponseDataProtocol {
    
}

struct ComicsResponseData: ComicsResponseDataProtocol, Codable {
    
    struct ComicsResultData: Codable {
        let results: [Comic]
    }
    
    let data: ComicsResultData
}
