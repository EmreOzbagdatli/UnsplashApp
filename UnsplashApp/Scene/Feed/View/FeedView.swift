//
//  FeedView.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 8.09.2023.
//

import SwiftUI
import Kingfisher

struct FeedView: View {

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]

    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        List(viewModel.feedImages) { feedItem in
            LazyVGrid(columns: columns) {
                KFImage(URL(string: "\(feedItem.urls.small)"))
                    .onAppear {
                    if feedItem.id == viewModel.feedImages.last?.id {
                        viewModel.getAllFeedImages()
                    }
                }
            }
        }.onAppear {
            viewModel.getAllFeedImages()
        }
    }

}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
