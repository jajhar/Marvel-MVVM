//
//  ComicService.swift
//  Marvel
//
//  Created by Julia Ajhar on 2/12/24.
//

import Foundation

protocol ComicServiceProtocol {
    func fetchComic(withId comicId: Int) async throws -> Comic
}

enum ComicServiceError: Error {
    case invalidURL
    case comicNotFound
}

struct ComicService: ComicServiceProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchComic(withId comicId: Int) async throws -> Comic {
        guard let request = APIRequest.fetchComic(comicId: comicId).request() else {
            throw ComicServiceError.invalidURL
        }
        
        let (data, _) = try await session.data(for: request)
        let response = try JSONDecoder().decode(ComicsResponseData.self, from: data)
        
        guard let result = response.data.results.first else {
            throw ComicServiceError.comicNotFound
        }
        
        return result
    }
}
