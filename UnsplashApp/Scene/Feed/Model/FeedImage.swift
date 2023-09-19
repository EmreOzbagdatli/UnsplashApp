//
//  FeedImageResponse.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 19.09.2023.
//

import Foundation

struct FeedImage: Decodable, Identifiable {
    let id: String
    let created_at: String
    let updated_at: String
    let likes: Int
    let liked_by_user: Bool
    let description: String?
    let urls: URLs
    
    struct URLs: Decodable {
        let raw, full, regular, small: String
        let thumb: String
    }
}
