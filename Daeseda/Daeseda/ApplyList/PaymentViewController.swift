//
//  PaymentViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/08.
//

import UIKit
import WebKit

class PaymentViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        let paymentURL = URL(string: "https://cdn.iamport.kr/v1/iamport.js")!
        
        // URLRequest를 생성하여 WebView에 로드
        webView.load(URLRequest(url: paymentURL))
    }
    
    // WKNavigationDelegate 메서드 - 웹페이지 로딩 완료 시 호출됨
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // 여기에 웹페이지 로딩이 완료된 후 추가 작업을 수행할 수 있습니다.
        }
}
