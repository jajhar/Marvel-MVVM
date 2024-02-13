//
//  ComicServiceTests.swift
//  MarvelTests
//
//  Created by Julia Ajhar on 2/12/24.
//

import XCTest
@testable import Marvel

final class ComicServiceTests: XCTestCase {

    func makeSUT(session: URLSession) -> ComicService {
        ComicService(session: session)
    }

    func test_fetchComic_success_responseModelParsing() async throws {
        guard let data = makeMockComicResponse().data(using: .utf8) else {
            XCTFail("Failed to create mock response")
            return
        }
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: URL(string: "https://gateway.marvel.com")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
            return (response, data)
        }
        
        // Create mock networker
        let networking = MockNetworking()
        
        let sut = makeSUT(session: networking.urlSession)
        
        let comic = try await sut.fetchComic(withId: 323)
        
        XCTAssertEqual(comic.id, 323)
        XCTAssertEqual(comic.title, "Ant-Man (2003) #2")
        XCTAssertEqual(comic.description, "test description")
        XCTAssertEqual(comic.images.first?.url?.absoluteString, "http://i.annihil.us/u/prod/marvel/i/mg/f/20/4bc69f33cafc0.jpg")
    }
}

extension ComicServiceTests {
    
    func makeMockComicResponse() -> String {
          """
          {
              "code": 200,
              "status": "Ok",
              "data": {
                  "results": [
                      {
                          "id": 323,
                          "title": "Ant-Man (2003) #2",
                          "description": "test description",
                          "images": [
                              {
                                  "path": "http://i.annihil.us/u/prod/marvel/i/mg/f/20/4bc69f33cafc0",
                                  "extension": "jpg"
                              }
                          ]
                      }
                  ]
              }
          }
          """
    }
}
