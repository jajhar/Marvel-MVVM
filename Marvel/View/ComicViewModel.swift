//
//  ComicViewModel.swift
//  Marvel
//
//  Created by Julia Ajhar on 2/12/24.
//

import Foundation

protocol ComicViewModelProtocol {
    var title: String? { get }
    var description: String? { get }
    var headerImage: ImageProtocol? { get }
    
    func fetchComic(withId comicId: Int)
}

enum ComicViewModelError: Error {
    case failedToFetchComic
}

class ComicViewModel: ObservableObject, ComicViewModelProtocol {
    private let service: ComicServiceProtocol
        
    @Published var comic: Comic?
    @Published var error: ComicViewModelError?
    
    var title: String? {
        comic?.title
    }
    
    var description: String? {
        comic?.description
    }
    
    var headerImage: ImageProtocol? {
        comic?.images.first
    }
    
    init(
        service: ComicServiceProtocol = ComicService(),
        comicId: Int = 323 // Ant-Man (2003) #2
    ) {
        self.service = service
        
        fetchComic(withId: comicId)
    }
    
    func fetchComic(withId comicId: Int) {
        Task {
            await callService(withComicId: comicId)
        }
    }
    
    private func callService(withComicId comicId: Int) async {
        do {
            let comic = try await service.fetchComic(withId: comicId)
            
            await MainActor.run {
                self.comic = comic
            }
        } catch {
            await MainActor.run {
                self.error = .failedToFetchComic
            }
        }
    }
}

// MARK: - Test Hooks
#if DEBUG
extension ComicViewModel {
    struct TestHooks {
        let target: ComicViewModel
        
        func fetchComic(withComicId comicId: Int) async {
            await target.callService(withComicId: comicId)
        }
    }
    
    var testHooks: TestHooks {
        TestHooks(target: self)
    }
}
#endif
