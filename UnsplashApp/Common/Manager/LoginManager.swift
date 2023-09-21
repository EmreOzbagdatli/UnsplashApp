//
//  LoginManager.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 19.09.2023.
//

import Foundation

final class LoginManager {
    static let shared = LoginManager()
    
    let html: String = ""
    
    var loggedOutReq: URLRequest?
    var loggedInReq: URLRequest?
    
    var token: String = ""
    
    func getCode(completionHandler: @escaping (String) -> Void) {
        guard let url = URL(string: "https://unsplash.com/oauth/authorize") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("\(Constant.clientID)", forHTTPHeaderField: "client_id")
        let session = URLSession.shared
        
        self.loggedOutReq = request
        
        session.dataTask(with: url) { data, response , error in
            if let data = data {
                response?.headerField(forKey: "redirect_uri")
                let html = String(data: data, encoding: .ascii)
                completionHandler(html ?? "")
            }
        }.resume()
        
        getToken { [weak self] response in
            self?.token = response.access_token
        }
    }
    
    
    func getToken(completionHandler: @escaping (BearerTokenResponse) -> Void) {
        guard let url = URL(string: "https://unsplash.com/oauth/token?grant_type=authorization_code") else { return }
        
        var request = URLRequest(url: url)
        request.setValue("\(Constant.clientID)", forHTTPHeaderField: "client_id")
        request.setValue("\(Constant.clientSecret)", forHTTPHeaderField: "client_secret")
        request.httpMethod = "POST"
        let session = URLSession.shared
        
        self.loggedInReq = request
        
        session.dataTask(with: url) { data, _ , error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let accessToken = try decoder.decode(BearerTokenResponse.self, from: data)
                    completionHandler(accessToken)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
}

struct BearerTokenResponse: Decodable {
    let access_token: String
}


extension URLResponse {
    func headerField(forKey key: String) -> String? {
        (self as? HTTPURLResponse)?.allHeaderFields[key] as? String
    }
}
