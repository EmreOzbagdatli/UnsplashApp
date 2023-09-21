//
//  ProfileView.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 8.09.2023.
//

import SwiftUI
import WebKit

struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            if !(viewModel.html.isEmpty) {
                Webview(web: WKWebView(), req: LoginManager.shared.loggedInReq!)
                     .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            } else {
                Button {
                    viewModel.loginUser()
                } label: {
                    Text("Log in")
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
