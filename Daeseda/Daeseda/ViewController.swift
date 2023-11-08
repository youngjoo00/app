//
//  ViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/13.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = false
        
        d()
        but()
        banner()
        fetchReview()
        //        loginButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        
    }
    var reviews: [ReviewData] = []
    var reviewCategory: [Categories] = []
    var reviewsWithCategory: [ReviewWithCategory] = []
    
    @IBOutlet weak var reviewScrollView: UIScrollView!
    
    func fetchReview(){
        let endPoint = "/review/list"
        
        let fullURL = baseURL.baseURLString + endPoint
        
        AF.request(fullURL, method: .get)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        self.reviews = try JSONDecoder().decode([ReviewData].self, from: data)
                        // 리뷰를 내림차순으로 정렬합니다.
                        self.reviews.sort { $0.reviewId > $1.reviewId }
                        
                        // 리뷰 카테고리를 저장할 배열을 초기화하고 빈 요소로 채웁니다.
                        self.reviewCategory = Array(repeating: Categories(categoryId: 0, categoryName: ""), count: self.reviews.count)
                        
                        // 리뷰 카테고리를 가져오기 위해 각 리뷰에 대한 인덱스와 함께 getReviewCategory를 호출합니다.
                        for (index, review) in self.reviews.enumerated() {
                            self.getReviewCategory(reviewId: review.reviewId, index: index)
                        }
                        
                        // 리뷰 및 카테고리를 결합하여 reviewsWithCategory 배열에 추가
                        self.reviewsWithCategory = self.reviews.enumerated().map { (index, review) in
                            return ReviewWithCategory(review: review, category: self.reviewCategory[index])
                        }
                        
                        // 모든 리뷰 카테고리 데이터를 수집한 후에 테이블 뷰를 업데이트합니다.
                        if self.reviewCategory.allSatisfy({ $0.categoryId != 0 && $0.categoryName != "" }) {
                            // 리뷰와 카테고리 정보를 함께 담은 배열 생성
                            self.reviewsWithCategory = self.combineReviewWithCategory()
                        }
                        print(self.reviewsWithCategory)
                        self.review()
                        
                    } catch {
                        print("리뷰 디코딩 실패: \(error)")
                    }
                case .failure(let error):
                    print("에러: \(error.localizedDescription)")
                }
            }
    }
    
    func getReviewCategory(reviewId: Int, index: Int) {
        let reviewCategoryUrl = baseURL.baseURLString + "/review-category/\(reviewId)"
        AF.request(reviewCategoryUrl, method: .get)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let reviewCategoryData = try JSONDecoder().decode([ReviewCategoryData].self, from: data)
                        if let firstCategory = reviewCategoryData.first {
                            self.reviewCategory[index] = firstCategory.categories
                            print(self.reviewCategory[index])
                        }
                        
                        // 모든 리뷰 카테고리 데이터를 수집한 후에 테이블 뷰를 업데이트합니다.
                        if self.reviewCategory.allSatisfy({ $0.categoryId != 0 && $0.categoryName != "" }) {
                            // 리뷰와 카테고리 정보를 함께 담은 배열 생성
                            self.reviewsWithCategory = self.combineReviewWithCategory()
                            
                        }
                    } catch {
                        print("리뷰 카테고리 디코딩 실패: \(error)")
                    }
                case .failure(let error):
                    print("에러: \(error.localizedDescription)")
                }
            }
    }
    
    func combineReviewWithCategory() -> [ReviewWithCategory] {
        var newData : [ReviewWithCategory] = []
        
        for (index, review) in self.reviews.enumerated() {
            let category = self.reviewCategory[index]
            newData.append(ReviewWithCategory(review: review, category: category))
        }
        
        return newData
    }
    
    
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
        
        reviewScrollView.frame = CGRect(x: 0, y: view.frame.height - 230, width: view.frame.width, height: 130)
        reviewScrollView.isPagingEnabled = true // 페이지별로 스크롤
        
        for i in 0..<reviewsWithCategory.count {
            let review = reviewsWithCategory[i].review
            let category = reviewsWithCategory[i].category
            
            let titleLabel = UILabel()
            let contentLabel = UILabel()
            let dateLabel = UILabel()
            var ratingImage = [UIImageView]()
            let xPos = reviewScrollView.frame.width * CGFloat(i)
            
            titleLabel.font = UIFont(name: "NotoSansKR-SemiBold", size: 20)
            titleLabel.frame = CGRect(x: xPos + 30, y: 0, width: reviewScrollView.frame.width, height: 30)
            titleLabel.text = review.userNickname
            reviewScrollView.addSubview(titleLabel)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
            
            if let date = dateFormatter.date(from: review.regDate) {
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let formattedDate = dateFormatter.string(from: date)
                dateLabel.text = formattedDate
            } else {
                dateLabel.text = "날짜 오류"
            }
            
            dateLabel.textColor = UIColor.gray
            dateLabel.font = UIFont(name: "NotoSansKR-Light", size: 16)
            dateLabel.frame = CGRect(x: xPos + 30, y: 0, width: reviewScrollView.frame.width - 50, height: 30)
            dateLabel.textAlignment = .right
            reviewScrollView.addSubview(dateLabel)
            
            contentLabel.frame = CGRect(x: xPos + 50, y: 30, width: reviewScrollView.frame.width, height: 80)
            contentLabel.text = review.reviewContent
            reviewScrollView.addSubview(contentLabel)
            
            var rating = Float(review.rating ?? 0)
            
            for j in 0..<Int(rating) {
                let starImage = UIImageView(image: UIImage(systemName: "star.fill"))
                starImage.frame = CGRect(x: xPos + 30 + CGFloat(j * 25), y: 30, width: 20, height: 20)
                starImage.tintColor = UIColor.systemYellow
                ratingImage.append(starImage)
                reviewScrollView.addSubview(starImage)
            }
            
            for j in Int(rating)..<5 {
                let starImage = UIImageView(image: UIImage(systemName: "star"))
                starImage.frame = CGRect(x: xPos + 30 + CGFloat(j * 25), y: 30, width: 20, height: 20)
//                starImage.tintColor = UIColor.yellow
                ratingImage.append(starImage)
                reviewScrollView.addSubview(starImage)
            }
        }
        
        reviewScrollView.contentSize = CGSize(width: reviewScrollView.frame.width * CGFloat(reviewsWithCategory.count), height: reviewScrollView.frame.height)
        view.addSubview(reviewScrollView)
    }
    
}

