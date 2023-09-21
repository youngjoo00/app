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

        d()
        but()
        banner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false

    }
    
    func d() {

        let view = UILabel()
        view.frame = CGRect(x: 0, y: 0, width: 158, height: 37)
        view.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.font = UIFont(name: "GmarketSans-Bold", size: 30)
        // Line height: 30 pt
        
        view.text = "서비스 이용"

        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 158).isActive = true
        view.heightAnchor.constraint(equalToConstant: 37).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 19).isActive = true
        view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 237).isActive = true
        
        let view2 = UILabel()
        view2.frame = CGRect(x: 0, y: 0, width: 152, height: 38)
        view2.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view2.font = UIFont(name: "GmarketSans-Bold", size: 30)
        // Line height: 30 pt
        view2.text = "리뷰"

        self.view.addSubview(view2)
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.widthAnchor.constraint(equalToConstant: 152).isActive = true
        view2.heightAnchor.constraint(equalToConstant: 38).isActive = true
        view2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 21).isActive = true
        view2.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 551).isActive = true
    }

    func but() {
        // 신청버튼
        let requestButton = UIButton()
        requestButton.frame = CGRect(x: 0, y: 0, width: 170, height: 221)
        requestButton.layer.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1).cgColor
        requestButton.layer.cornerRadius = 30

        self.view.addSubview(requestButton)
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        requestButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
        requestButton.heightAnchor.constraint(equalToConstant: 221).isActive = true
        requestButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 21).isActive = true
        requestButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 297).isActive = true
        
        // 버튼을 누를 때 RequestViewController 화면 전환
        requestButton.addTarget(self, action: #selector(showRequestViewController), for: .touchUpInside)
        
        // 신청 라벨
        let requestText = UILabel()
        requestText.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        requestText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        requestText.font = UIFont(name: "GmarketSans-Bold", size: 25)
        requestText.numberOfLines = 0
        requestText.lineBreakMode = .byWordWrapping
        // Line height: 25 pt
        requestText.text = "세탁\n신청"

        self.view.addSubview(requestText)
        requestText.translatesAutoresizingMaskIntoConstraints = false
        requestText.widthAnchor.constraint(equalToConstant: 164).isActive = true
        requestText.heightAnchor.constraint(equalToConstant: 208).isActive = true
        requestText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 33).isActive = true
        requestText.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250).isActive = true
        
        // 신청 이미지
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 91, height: 102)
        let requstImage = UIImage(named: "신청버튼")?.cgImage
        let layer0 = CALayer()
        layer0.contents = requstImage
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.12, b: 0, c: 0, d: 1, tx: -0.06, ty: 0))
        layer0.bounds = view.bounds
        layer0.position = view.center
        view.layer.addSublayer(layer0)

        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 91).isActive = true
        view.heightAnchor.constraint(equalToConstant: 102).isActive = true
        view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 92).isActive = true
        view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 321).isActive = true
        
        //신청 화살표
        let arrow = UIView()
        arrow.frame = CGRect(x: 0, y: 0, width: 95, height: 20)
        let arrowImage = UIImage(named: "화살표")?.cgImage
        let layer1 = CALayer()
        layer1.contents = arrowImage
//        layer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1.12, b: 0, c: 0, d: 1, tx: -0.06, ty: 0))
        layer1.bounds = arrow.bounds
        layer1.position = arrow.center
        arrow.layer.addSublayer(layer1)

        self.view.addSubview(arrow)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.widthAnchor.constraint(equalToConstant: 116).isActive = true
        arrow.heightAnchor.constraint(equalToConstant: 0).isActive = true
        arrow.centerXAnchor.constraint(equalTo: requestButton.centerXAnchor).isActive = true
        arrow.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 480).isActive = true
        
        // 가격표 버튼
        let priceButton = UIButton()
        priceButton.frame = CGRect(x: 0, y: 0, width: 162, height: 90)
        priceButton.layer.backgroundColor = UIColor(red: 0.612, green: 0.725, blue: 0.969, alpha: 1).cgColor
        priceButton.layer.cornerRadius = 30

        self.view.addSubview(priceButton)
        priceButton.translatesAutoresizingMaskIntoConstraints = false
        priceButton.widthAnchor.constraint(equalToConstant: 162).isActive = true
        priceButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        priceButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 210).isActive = true
        priceButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 304).isActive = true
        
        //가격표 라벨
        let priceText = UILabel()
        priceText.frame = CGRect(x: 0, y: 0, width: 162, height: 35)
        priceText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        priceText.font = UIFont(name: "GmarketSans-Bold", size: 25)
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
        useButton.widthAnchor.constraint(equalToConstant: 162).isActive = true
        useButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        useButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 210).isActive = true
        useButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 422).isActive = true

        // 이용방법 라벨
        // Auto layout, variables, and unit scale are not yet supported
        let useText = UILabel()
        useText.frame = CGRect(x: 0, y: 0, width: 162, height: 34)
        useText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        useText.font = UIFont(name: "GmarketSans-Bold", size: 25)
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
    
    @objc func showRequestViewController() {
        guard  let requestVC = storyboard?.instantiateViewController(withIdentifier: "request") as? RequestViewController else { return }
        self.navigationController?.pushViewController(requestVC, animated: true)
    }

    let scrollView = UIScrollView()
    let pageControl = UIPageControl()

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

        // UIPageControl 추가
        pageControl.numberOfPages = images.count
        pageControl.currentPageIndicatorTintColor = UIColor(named: "FFC965") // 해당
        pageControl.currentPage = 0
        pageControl.frame = CGRect(x: 0, y: scrollView.frame.maxY - 30, width: scrollView.frame.width, height: 30)
        pageControl.addTarget(self, action: #selector(pageControlDidChange), for: .valueChanged)
        view.addSubview(pageControl)
        

    }
    @objc func pageControlDidChange(_ sender: UIPageControl) {
        let x = CGFloat(sender.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    //현재 페이지를 pageControl의 currentPage 속성에 설정
    func selectedPage(currentPage: Int) {
        pageControl.currentPage = currentPage
    }
    
    //현재 페이지를 업데이트
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        pageControl.currentPage = currentPage
    }
}

