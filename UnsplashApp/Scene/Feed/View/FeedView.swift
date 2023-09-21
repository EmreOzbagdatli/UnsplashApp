//
//  FeedView.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 8.09.2023.
//

import SwiftUI
import Kingfisher

struct FeedView: View {

    @State var searchTerm :String = ""
    @State var expand = false

    let columns = [
        GridItem(.adaptive(minimum: 200))
    ]

    @StateObject private var viewModel = FeedViewModel()

    var body: some View {
        
        
        
            VStack(spacing: 0) {

                HStack{
                    
                    if !self.expand{
                        VStack(alignment: .leading,spacing: 8) {
                            Text("Unsplash")
                                .font(.title)
                                .fontWeight(.bold)
                            Text("Beatiful, Free Photos")
                                
                                            

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
                    if self.expand{
                        TextField("Search...",text: $searchTerm)
                        
                        if self.searchTerm != "" {
                            Button(action:{
                                
                            }){
                                
                                Text("Find")
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                        }
                        
                        Button(action: {
                            withAnimation {
                                self.expand = false
                            }
                            
                        }){
                            Image(systemName: "xmark")
                                .font(.system(size: 15,weight: .bold))
                                .foregroundColor(.black)
                        }
                        .padding(.leading,10)
                    }
                }.padding(.all)
                
                
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

}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
