//
//  SafariView.swift
//  UnsplashApp
//
//  Created by Emre Özbağdatlı on 19.09.2023.
//

import SwiftUI
import SafariServices
import WebKit

struct Webview : UIViewRepresentable {
    let request: URLRequest
    var webview: WKWebView?

    init(web: WKWebView?, req: URLRequest) {
        self.webview = WKWebView()
        self.request = req
    }

    class Coordinator: NSObject, WKUIDelegate {
        var parent: Webview

        init(_ parent: Webview) {
            self.parent = parent
        }

        // Delegate methods go here

        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            // alert functionality goes here
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        return webview!
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.uiDelegate = context.coordinator
        uiView.load(request)
    }

    func goBack() {
        webview?.goBack()
    }

    func goForward() {
        webview?.goForward()
    }

    func reload() {
        webview?.reload()
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let httpResponse = navigationResponse.response as? HTTPURLResponse {
            let headerFields = httpResponse.allHeaderFields
            // Access headerFields to get the response headers

            // Example: Print all response headers
            for (key, value) in headerFields {
                print("\(key): \(value)")
            }
        }

        // Continue with the navigation action
        decisionHandler(.allow)
    }
}
