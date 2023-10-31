//
//  ViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/13.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        
        d()
        but()
        banner()
        loginButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
    
    var tittle:[String] = ["a", "s"]
    var writeNick:[String] = ["1", "2"]
    var Content:[String] = ["qwer", "asdf"]
    
    @IBOutlet weak var reviewScrollView: UIScrollView!
    
    
    func d() {
        
        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 158, height: 37)
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "GmarketSansTTFBold", size: 25)
        // Line height: 30 pt
        
        view.text = "서비스 이용"
        
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 225).isActive = true
        
        let view2 = UILabel()
        view2.frame = CGRect(x: 0, y: 0, width: 152, height: 38)
        view2.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view2.font = UIFont(name: "GmarketSansTTFBold", size: 25)
        // Line height: 30 pt
        view2.text = "리뷰"
        
        self.view.addSubview(view2)
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        view2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 545).isActive = true
    }
    
    func but() {
        // 신청버튼
        let requestButton = UIButton()
        requestButton.frame = CGRect(x: 0, y: 0, width: 170, height: 221)
        requestButton.layer.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1).cgColor
        requestButton.layer.cornerRadius = 30
        
        self.view.addSubview(requestButton)
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        requestButton.heightAnchor.constraint(equalToConstant: 221).isActive = true
        requestButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        requestButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -200).isActive = true
        requestButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 280).isActive = true
        
        // 버튼을 누를 때 RequestViewController 화면 전환
        requestButton.addTarget(self, action: #selector(requestVC), for: .touchUpInside)
        
        // 신청 라벨
        let requestText = UILabel()
        requestText.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        requestText.textColor = UIColor.black
        requestText.font = UIFont(name: "GmarketSansTTFBold", size: 20)
        requestText.numberOfLines = 0
        requestText.lineBreakMode = .byWordWrapping
        // Line height: 25 pt
        requestText.text = "세탁\n신청"
        
        self.view.addSubview(requestText)
        requestText.translatesAutoresizingMaskIntoConstraints = false
        requestText.leadingAnchor.constraint(equalTo: requestButton.leadingAnchor, constant: 20).isActive = true
        requestText.topAnchor.constraint(equalTo: requestButton.topAnchor, constant: 33).isActive = true
        
        // 신청 이미지
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        let requstImage = UIImage(named: "신청버튼")?.cgImage
        let layer0 = CALayer()
        layer0.contents = requstImage
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.12, b: 0, c: 0, d: 1, tx: -0.06, ty: 0))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)
        
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 120).isActive = true
        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        view.trailingAnchor.constraint(equalTo: requestButton.trailingAnchor, constant: 15).isActive = true
        view.bottomAnchor.constraint(equalTo: requestButton.bottomAnchor, constant: -33).isActive = true
        
        let whiteView = UIView()
        whiteView.frame = CGRect(x: 0, y: 0, width: 120, height: 120)
        whiteView.backgroundColor = UIColor.white
        
        self.view.addSubview(whiteView)
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        whiteView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        whiteView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        whiteView.trailingAnchor.constraint(equalTo: requestButton.trailingAnchor, constant: 30).isActive = true
        whiteView.bottomAnchor.constraint(equalTo: requestButton.bottomAnchor, constant: -33).isActive = true
        
        //신청 화살표
        let arrow = UIView()
        arrow.frame = CGRect(x: 0, y: 0, width: 90, height: 60)
        let arrowImage = UIImage(named: "화살표")?.cgImage
        let layer1 = CALayer()
        layer1.contents = arrowImage
        layer1.bounds = arrow.bounds
        layer1.position = arrow.center
        arrow.layer.addSublayer(layer1)
        
        self.view.addSubview(arrow)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.widthAnchor.constraint(equalToConstant: 90).isActive = true
        arrow.heightAnchor.constraint(equalToConstant: 60).isActive = true
        arrow.centerXAnchor.constraint(equalTo: requestButton.centerXAnchor).isActive = true
        arrow.bottomAnchor.constraint(equalTo: requestButton.bottomAnchor, constant: 10).isActive = true
        
        // 가격표 버튼
        let priceButton = UIButton()
        priceButton.frame = CGRect(x: 0, y: 0, width: 162, height: 90)
        priceButton.layer.backgroundColor = UIColor(red: 0.612, green: 0.725, blue: 0.969, alpha: 1).cgColor
        priceButton.layer.cornerRadius = 30
        
        self.view.addSubview(priceButton)
        priceButton.translatesAutoresizingMaskIntoConstraints = false
        priceButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        priceButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200).isActive = true
        priceButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        priceButton.topAnchor.constraint(equalTo: requestButton.topAnchor, constant: 10).isActive = true
        
        priceButton.addTarget(self, action: #selector(priceListVC), for: .touchUpInside)
        
        
        //가격표 라벨
        let priceText = UILabel()
        priceText.frame = CGRect(x: 0, y: 0, width: 162, height: 35)
        priceText.textColor = UIColor.black
        priceText.font = UIFont(name: "GmarketSansTTFBold", size: 20)
        // Line height: 25 pt
        priceText.textAlignment = .center
        priceText.text = "가격표"
        
        self.view.addSubview(priceText)
        priceText.translatesAutoresizingMaskIntoConstraints = false
        priceText.widthAnchor.constraint(equalToConstant: 162).isActive = true
        priceText.heightAnchor.constraint(equalToConstant: 35).isActive = true
        priceText.centerXAnchor.constraint(equalTo: priceButton.centerXAnchor).isActive = true
        priceText.centerYAnchor.constraint(equalTo: priceButton.centerYAnchor).isActive = true
        
        // 이용방법 버튼
        let useButton = UIButton()
        useButton.frame = CGRect(x: 0, y: 0, width: 162, height: 90)
        useButton.layer.backgroundColor = UIColor(red: 0.796, green: 0.859, blue: 0.984, alpha: 1).cgColor
        useButton.layer.cornerRadius = 30
        
        self.view.addSubview(useButton)
        useButton.translatesAutoresizingMaskIntoConstraints = false
        useButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        useButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200).isActive = true
        
        useButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        useButton.bottomAnchor.constraint(equalTo: requestButton.bottomAnchor, constant: -10).isActive = true
        
        useButton.addTarget(self, action: #selector(useWayVC), for: .touchUpInside)
        
        // 이용방법 라벨
        // Auto layout, variables, and unit scale are not yet supported
        let useText = UILabel()
        useText.frame = CGRect(x: 0, y: 0, width: 162, height: 34)
        useText.textColor = UIColor.black
        useText.font = UIFont(name: "GmarketSansTTFBold", size: 20)
        // Line height: 25 pt
        useText.textAlignment = .center
        useText.text = "이용방법"
        
        self.view.addSubview(useText)
        useText.translatesAutoresizingMaskIntoConstraints = false
        useText.widthAnchor.constraint(equalToConstant: 162).isActive = true
        useText.heightAnchor.constraint(equalToConstant: 34).isActive = true
        useText.centerXAnchor.constraint(equalTo: useButton.centerXAnchor).isActive = true
        useText.centerYAnchor.constraint(equalTo: useButton.centerYAnchor).isActive = true
        
    }
    
    @objc func requestVC() {
        guard  let requestVC = storyboard?.instantiateViewController(withIdentifier: "request") as? RequestViewController else { return }
        self.navigationController?.pushViewController(requestVC, animated: true)
    }
    
    @objc func useWayVC() {
        guard  let useWayVC = storyboard?.instantiateViewController(withIdentifier: "useWay") as? UseWayViewController else { return }
        self.navigationController?.pushViewController(useWayVC, animated: true)
    }
    
    @objc func priceListVC() {
        guard  let priceListVC = storyboard?.instantiateViewController(withIdentifier: "priceList") as? PriceListViewController else { return }
        self.navigationController?.pushViewController(priceListVC, animated: true)
    }
    
    func loginButton(){
        let nextButton = UIButton(type: .custom)
        nextButton.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        nextButton.setTitle("로그인", for: .normal)
        nextButton.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1)
        nextButton.setTitleColor(UIColor.black, for: .normal)
        nextButton.layer.cornerRadius = 12
        nextButton.addTarget(self, action: #selector(LoginVC), for: .touchUpInside) // 버튼 탭 액션 추가
        
        // 커스텀 버튼을 UIBarButtonItem로 변환
        let customBarButtonItem = UIBarButtonItem(customView: nextButton)
        
        // 네비게이션 바에 추가
        navigationItem.rightBarButtonItem = customBarButtonItem
        
    }
    
    @objc func LoginVC() {
        guard let loginVC = storyboard?.instantiateViewController(withIdentifier: "Login") as? LoginViewController else { return }
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    let scrollView = UIScrollView()
    
    func banner() {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        scrollView.isPagingEnabled = true // 페이지별로 스크롤
        
        var images = ["홍보배너1", "홍보배너2", "홍보배너3"]
        
        for i in 0..<images.count {
            let imageView = UIImageView()
            let xPos = scrollView.frame.width * CGFloat(i)
            
            imageView.frame = CGRect(x: xPos, y: 0, width: scrollView.frame.width, height: 200)
            imageView.image = UIImage(named: images[i])
            scrollView.addSubview(imageView)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(images.count), height: scrollView.frame.height)
        view.addSubview(scrollView)
        
    }
    
    @objc func pageControlDidChange(_ sender: UIPageControl) {
        let x = CGFloat(sender.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    func review(){
        reviewScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        reviewScrollView.isPagingEnabled = true // 페이지별로 스크롤
        
        for i in 0..<tittle.count {
            let tittleLabel = UILabel()
            let xPos = reviewScrollView.frame.width * CGFloat(i)
            
            tittleLabel.frame = CGRect(x: xPos, y: 0, width: reviewScrollView.frame.width, height: 200)
            tittleLabel.text = tittle[i]
            reviewScrollView.addSubview(tittleLabel)
        }
        
        reviewScrollView.contentSize = CGSize(width: reviewScrollView.frame.width * CGFloat(tittle.count), height: reviewScrollView.frame.height)
        view.addSubview(reviewScrollView)
    }
    
}

