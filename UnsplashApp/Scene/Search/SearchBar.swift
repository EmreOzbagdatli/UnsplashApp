//
//  SearchBar.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 21.09.2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            
            TextField("Ara...", text: $searchText)
                .frame(alignment: .center)
            Button(action: {
                searchText = ""
            }) {
                
              
            }
            .opacity(searchText.isEmpty ? 0 : 1)
        }
        .background(Color(.systemGray6))
    }
}

