//
//  ComicViewModelTests.swift
//  MarvelTests
//
//  Created by Julia Ajhar on 2/12/24.
//

import XCTest
@testable import Marvel

final class ComicViewModelTests: XCTestCase {
    func makeSUT(service: ComicServiceProtocol) -> ComicViewModel {
        ComicViewModel(service: service)
    }
    
    func test_fetchComic_success_modelUpdates() async throws {
        let service = MockComicService(comicResponse: Comic(
            id: 123,
            title: "title",
            description: "description",
            images: [.init(path: "path", ext: "ext")]
        ))

        let sut = makeSUT(service: service)
        await sut.testHooks.fetchComic(withComicId: 123)
        
        XCTAssertEqual(sut.comic?.id, 123)
        XCTAssertEqual(sut.title, "title")
        XCTAssertEqual(sut.description, "description")
        XCTAssertEqual(sut.headerImage?.url?.absoluteString, "path.ext")
    }
    
    func test_fetchComic_failure_errorUpdates() async throws {
        let service = MockComicService(errorResponse: .comicNotFound)
        let sut = makeSUT(service: service)
        await sut.testHooks.fetchComic(withComicId: 123)

        XCTAssertNil(sut.comic)
        XCTAssertEqual(sut.error, .failedToFetchComic)
    }
}

private struct MockComicService: ComicServiceProtocol {
    var comicResponse: ComicProtocol?
    var errorResponse: ComicServiceError?
    
    func fetchComic(withId comicId: Int) async throws -> ComicProtocol {
        if let comic = comicResponse {
            return comic
        }
        
        throw errorResponse ?? ComicServiceError.comicNotFound
    }
}
