//
//  ContentView.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 4.09.2023.
//


import SwiftUI

struct MainView: View {
    @State private var isLoggedIn = true

    var body: some View {
        if isLoggedIn {
            return AnyView(TabBar())
        } else {
            return AnyView(LoginView())
        }
    }
}

