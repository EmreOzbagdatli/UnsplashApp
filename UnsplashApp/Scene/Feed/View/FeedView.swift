//
//  FeedView.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 8.09.2023.
//

import SwiftUI
import Kingfisher

struct FeedView: View {
    @State var searchTerm: String = ""
    @State var expand = false

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if !self.expand {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Unsplash")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("Beautiful, Free Photos")
                    }
                        .foregroundColor(.black)
                }
                Spacer(minLength: 0)
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .onTapGesture {
                    withAnimation {
                        self.expand = true
                    }
                }
                if self.expand {
                    TextField("Search...", text: $searchTerm)
                    if self.searchTerm != "" {
                        Button(action: {
                        }) {
                            Text("Find")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    Button(action: {
                        withAnimation {
                            self.expand = false
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.black)
                    }
                        .padding(.leading, 10)
                }
            }
                .padding(.horizontal)

            List(viewModel.feedImages) { feedItem in
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(viewModel.feedImages, id: \.id) { feedItem in
                        ZStack(alignment: .bottomTrailing) {
                            KFImage(URL(string: "\(feedItem.urls.small)"))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width / 3)
                                
                                .cornerRadius(4)
                                

                            HStack(spacing: 2) {
                                Image(systemName: "heart")
                                    .foregroundColor(.white)
                                Text("\(feedItem.likes)")
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    
                            }
                            .padding(5)
                        }
                    }
                }

                
            }.scrollContentBackground(.hidden)
                .onAppear {
                viewModel.getAllFeedImages()
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
