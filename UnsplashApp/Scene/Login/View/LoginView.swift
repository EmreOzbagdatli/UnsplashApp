//
//  LoginView.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 8.09.2023.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Kullanıcı Adı", text: $username)
                    .padding()
                SecureField("Şifre", text: $password)
                    .padding()
       
                if isLoggedIn == true {
                    Text("xd")
                }
            }
        }
    }

    func isValidUser(username: String, password: String) -> Bool {
        return username == "1" && password == "1"
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


