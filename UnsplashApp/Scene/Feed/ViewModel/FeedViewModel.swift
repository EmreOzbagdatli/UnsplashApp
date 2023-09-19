//
//  FeedViewModel.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 19.09.2023.
//

import Foundation


final class FeedViewModel: ObservableObject {
    @Published var feedImages: [FeedImage] = []
    @Published var error: String = ""

    func getAllFeedImages() {
        FeedViewImageManager.shared.fetchFeedImages { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let feedItems):
                DispatchQueue.main.async { [weak self] in
                    self?.feedImages.append(contentsOf: feedItems)
                }
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.error = "\(error)"
                }
            }
        }
    }
}
