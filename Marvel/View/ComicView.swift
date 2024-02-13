//
//  ComicView.swift
//  Marvel
//
//  Created by Julia Ajhar on 2/12/24.
//

import SwiftUI

struct ComicView: View {
    @ObservedObject var viewModel: ComicViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if let imageURL = viewModel.headerImage?.url {
                    headerImage(imageURL: imageURL)
                }
                if let title = viewModel.title {
                    Text(title)
                        .accessibilityIdentifier("comicTitle")
                }
                if let description = viewModel.description {
                    Text(description)
                        .accessibilityIdentifier("comicDescription")
                }
            }
        }
    }
    
    private func headerImage(imageURL: URL) -> some View {
        Rectangle()
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                AsyncImage(
                    url: imageURL,
                    content: { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .accessibilityIdentifier("headerImage")
                    },
                    placeholder: {
                        ProgressView()
                    }
                )
            )
            .clipShape(Rectangle())
    }
}

struct ComicView_Previews: PreviewProvider {
    static var previews: some View {
        ComicView(viewModel: .init(service: MockService()))
    }
    
    struct MockService: ComicServiceProtocol {
        func fetchComic(withId comicId: Int) async throws -> Comic {
            return .init(id: 123, title: "Comic title", description: "Comic description", images: [])
        }
    }
}
