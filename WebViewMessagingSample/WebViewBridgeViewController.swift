//
//  WebViewBridgeViewController.swift
//  WebViewRemoteMessagingSample
//
//  Created by Arin Cranley on 2023/01/01.
//  Copyright © 2023/01/01 Arin Cranley. All rights reserved.
//

import Foundation
import WebKit

// WebViewBridgeViewController
final class WebViewBridgeViewController : UIViewController {
    @IBOutlet weak var webViewContainer: UIView!
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadURL()
    }
}
// Setup WebView and Load URL
private extension WebViewBridgeViewController {
    func setupView() {
        // Bridge Setting
        let userController: WKUserContentController = WKUserContentController()
        userController.add(self, name: "gardenAppMessageHandler")

        // WebView Setting
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userController
        
        // Default WebView Setting
        self.webView = WKWebView(frame:self.webViewContainer.bounds, configuration: configuration)
        self.webViewContainer.addSubview(self.webView)
        
    }

    func loadURL() {
        guard let  url = URL(string: "https://theorian.com/garden-games/index.html") else {
            return
        }
        let request = URLRequest(url: url)
        self.webView.load(request)
    }
}
// WKScriptMessageHandler
extension WebViewBridgeViewController : WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("message.name:\(message.name)")
        print("message.body:\(message.body)")

        // if message.body is "close", then close the webViewContainer
        if message.body as? String == "close" {
            self.webViewContainer.removeFromSuperview()
        }
    }
}
