//
//  FeedViewImageManager.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 19.09.2023.
//

import Foundation

enum NetworkError: Error {
    case DecodeError
    case URLError
    case someError(error: Error)
}

final class FeedViewImageManager {
    static let shared = FeedViewImageManager()
    
    func fetchFeedImages(completionHandler: @escaping (Result<[FeedImage], NetworkError>) -> Void) {
        guard let url = URL(string: Constant.baseurl + "/" + Constant.photoUrl + "?client_id=\(Constant.clientID)") else {
            completionHandler(.failure(NetworkError.URLError))
            return
        }
        
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completionHandler(.failure(NetworkError.someError(error: error)))
                return
            }
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let decodedData = try decoder.decode([FeedImage].self, from: data)
                    completionHandler(.success(decodedData))
                } catch {
                    completionHandler(.failure(NetworkError.DecodeError))
                }
            }
        }.resume()
    }
}
