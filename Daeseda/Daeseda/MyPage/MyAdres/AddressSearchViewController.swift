import UIKit
import WebKit

class AddressSearchViewController: UIViewController {
    
    
    var webView: WKWebView?
    let indicator = UIActivityIndicatorView(style: .medium)
    var address = ""
    var zonecode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAddressSearchNotification(_:)), name: NSNotification.Name("postAddressNotification"), object: nil)
    }
    
    @objc func handleAddressSearchNotification(_ notification: Notification) {
        if let searchText = notification.object as? String {
            // 검색어를 사용하여 필요한 작업을 수행
            print("검색어: \(searchText)")
        }
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
    
    // 검색이 끝난 후 MoreAdressVC로 화면 전환
    func transitionToMoreAdressVC() {
        guard let moreAdressVC = storyboard?.instantiateViewController(withIdentifier: "MoreAdressVC") as? MoreAdressViewController else { return }
        moreAdressVC.address = address
        navigationController?.pushViewController(moreAdressVC, animated: true)
    }
}

// 주소 검색 후 선택하였을 경우 호출
extension AddressSearchViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // data에는 zonecode,jibunAddress, roadAddress 담아있음
        if let data = message.body as? [String: Any] {
            address = data["roadAddress"] as? String ?? ""
            zonecode = data["zonecode"] as? String ?? ""
        }
        
        let userInfo: [String: Any] = ["address": address, "zonecode": zonecode]
        NotificationCenter.default.post(name:NSNotification.Name("postAddressNotification"), object: nil, userInfo: userInfo)


        transitionToMoreAdressVC()
        
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
