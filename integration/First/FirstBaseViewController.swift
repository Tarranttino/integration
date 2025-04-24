//
//  FirstBaseViewController.swift
//  integration
//
//  Created by Taras on 23.04.2025.
//

import UIKit
import WebKit
import FirebaseDatabase

class FirstBaseViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        configuration.allowsAirPlayForMediaPlayback = true
        configuration.allowsInlineMediaPlayback = true
        configuration.allowsPictureInPictureMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
        return webView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
    
    func setUI() {
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.addSubview(webView)
        view.backgroundColor = .black
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        view.bringSubviewToFront(webView)
    }
    
    func goToWhite() {
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    func fetch() {
        let fetchManager = FetchManager()

        fetchManager.fetchApp(withID: Constants.appId) { app in
            if let app = app {
                print("Found app: \(app.name)")
                self.checkActive(app: app)
            } else {
                print("App not found")
                //white
                self.goToWhite()
            }
        }
    }
    
    func checkActive(app: App) {
        if app.active {
            print("App is active")
            checkGeo(app: app)
        } else {
            print("App is not active")
            //white
            self.goToWhite()
        }
    }
    
    func checkGeo(app: App) {
        
        let locale = Locale.current.regionCode ?? ""
        
        guard let offers = app.offers else {
            //white
            self.goToWhite()
            return
        }
        
        var goodOffers: [Offer] = []
        
        for (_, offer) in offers {
            if offer.geo == locale {
                print("Locale is \(locale)")
                print("Offer geo is \(offer.geo)")
                print("Geo matches!")
                goodOffers.append(offer)
            } else {
                print("Locale is \(locale)")
                print("Offer geo is \(offer.geo)")
                print("Geo does not matches!")
            }
        }
        
        //split
        if !goodOffers.isEmpty {
            print("Offers count: \(goodOffers.count)")
            splitOffers(offers: goodOffers)
        } else {
            //white
            print("goodOffers is empty!")
            self.goToWhite()
        }
        
    }
    
    func splitOffers(offers: [Offer]) {
        let random = Int.random(in: 0..<100)
        
        var cumulative = 0
        for offer in offers {
            cumulative += offer.percentage
            print("cumulative is \(cumulative)")
            if random < cumulative {
                print("Random number is \(random)")
                print("Offer is \(offer.affId)")
                configureLink(url: offer.trackLink)
                break
            }
        }
    }
    
    func configureLink(url: String) {
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        var urlString = ""
        
        urlString = url.replacingOccurrences(of: "{appId}", with: Constants.appId)
        urlString = urlString.replacingOccurrences(of: "{deviceId}", with: deviceId)
        urlString = urlString.replacingOccurrences(of: "{clickId}", with: deviceId)
        
        print("Final url: \(urlString)")
        loadLink(urlString: urlString)
    }
    
    func loadLink(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.main.async {
            self.setUI()
            self.webView.load(URLRequest(url: url))
        }
    }
    
    
}

//extension FirstBaseViewController: WKUIDelegate, WKNavigationDelegate {
//    
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
//        print("Navigating to: \(navigationAction.request.url?.absoluteString ?? "Unknown URL")")
//        return .allow
//    }
//    
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//        print("did finish: \(webView.url?.absoluteString)")
//    }
//    
//    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
//        print("error in load: \(error.localizedDescription)")
//    }
//    
//}
