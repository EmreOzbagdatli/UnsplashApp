//
//  FeedView.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 8.09.2023.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
            
        Image(systemName: "heart")
            .resizable()
            .frame(width: 200,height: 200,alignment: .center)
            .onAppear {
                FeedViewImageManager.shared.fetchFeedImages { result in
                    switch result {
                    case .success(let images):
                        print(images)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
