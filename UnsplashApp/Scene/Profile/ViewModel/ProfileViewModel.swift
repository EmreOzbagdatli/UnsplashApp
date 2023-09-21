//
//  ProfileViewModel.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 19.09.2023.
//

import Foundation

final class ProfileViewModel: ObservableObject {
    
    @Published var html: String = ""
    
    func loginUser() {
        LoginManager.shared.getCode(completionHandler: { [weak self] html in
            DispatchQueue.main.async {
                self?.html = html
                print(self?.html)
            }
        })
    }
}
