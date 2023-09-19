//
//  FeedView.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 8.09.2023.
//

import SwiftUI
import Kingfisher

struct FeedView: View {

    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        ScrollView {
            if !(viewModel.error.isEmpty) || !(viewModel.error == "") {
                Text(viewModel.error)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(15)
            } else {
                List(filteredCharacters) { character in
                                LazyVGrid(columns: columns) {
                                    NavigationLink(destination: CharacterDetailView(character: character)) {
                                        CharacterListCellView(character: character)
                                            .onAppear {
                                            if character.id == filteredCharacters.count - 1 {
                                                viewModel.fetchNextCharacters()
                                            }
                                        }
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
