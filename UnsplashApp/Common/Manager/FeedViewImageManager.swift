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
    
    var currentIndex = 0
    
    func fetchFeedImages(completionHandler: @escaping (Result<[FeedImage], NetworkError>) -> Void) {
        currentIndex += 1
        guard let url = URL(string: Constant.baseurl + "/" + Constant.photoUrl + "/?page=\(currentIndex)") else {
            completionHandler(.failure(NetworkError.URLError))
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Client-ID \(Constant.clientID)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        print(url)
        
        
        session.dataTask(with: request) { data, _, error in
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
