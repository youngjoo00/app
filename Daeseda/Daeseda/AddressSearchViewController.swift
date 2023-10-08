//
//  AddressSearchViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/05.
//

import UIKit
import WebKit

class AddressSearchViewController: UIViewController {
    

    var webView: WKWebView?
    let indicator = UIActivityIndicatorView(style: .medium)
    var address = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        setAttributes()
        setContraints()
    }
    
    func setAttributes() {
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController

        webView = WKWebView(frame: .zero, configuration: configuration)
        webView?.navigationDelegate = self
        
        guard let url = URL(string: "https://2sso.github.io/Kakao-PostService/"),
              let webView = webView
        else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        indicator.startAnimating()
    }
    
    // webView 레이아웃 설정
    func setContraints() {
        guard let webView = webView else { return }
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        
        webView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        
    }
}
// 주소 검색 후 선택하였을 경우 호출
extension AddressSearchViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // data에는 zonecode,jibunAddress, roadAddress 담아있음
        if let data = message.body as? [String: Any] {
            address = data["roadAddress"] as? String ?? ""
            print(data)
            print(address)
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("postAddressNotification"), object: address)

        self.dismiss(animated: true, completion: nil)

    }
}

// webView가 로드될 때 indicator을 보여주기 위함
extension AddressSearchViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        indicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        indicator.stopAnimating()
    }
}
