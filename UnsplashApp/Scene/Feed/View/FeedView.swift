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
        
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
