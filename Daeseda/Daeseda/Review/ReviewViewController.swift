import UIKit
import Alamofire

class ReviewViewController: UIViewController {
    
    let endPoint = "/review/list"
    var reviews: [ReviewData] = []
    var reviewCategory: [Categories] = []
    var reviewsWithCategory: [ReviewWithCategory] = []  // ReviewWithCategory 배열 선언
    
    // 피커뷰와 관련된 변수
    var categoryPickerView: UIPickerView?
    var selectedCategory: String?
    
    let reviewCategorys = [
        "전체",
        "상의",
        "하의",
        "이불"
    ]
    
    @IBOutlet weak var reviewListTableView: UITableView!
    @IBOutlet weak var reviewCategoryTF: UITextField!
    @IBOutlet weak var reviewListCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewListTableView.dataSource = self
        reviewListTableView.delegate = self
        
        reviewListTableView.rowHeight = UITableView.automaticDimension
        reviewListTableView.estimatedRowHeight = UITableView.automaticDimension
        
        reviewCategoryTF.layer.cornerRadius = 13
        reviewCategoryTF.clipsToBounds = true
        
        // 타이틀 텍스트 폰트 조절
        if let navigationBar = self.navigationController?.navigationBar {
            let font = WDFont.GmarketBold.of(size: 30)
            navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        
        setupCategoryPickerView()
        
        // 기본적으로 "전체" 카테고리 선택
        selectedCategory = "전체"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 화면이 나타날 때 리뷰 목록을 리로드
        getReviewData()
        filterReviewsByCategory()
        selectedCategory = "전체"
    }
    
    func getReviewData() {
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
                            
                            // 테이블 뷰를 업데이트
                            self.reviewListTableView.reloadData()
                        }
                        
                        self.reviewListCount.text = "\(self.reviewsWithCategory.count)"
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
                            
                            // 테이블 뷰를 업데이트
                            self.reviewListTableView.reloadData()
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
    
    func filterReviewsByCategory() {
        if selectedCategory == "전체" {
            // "전체" 카테고리를 선택한 경우, 모든 리뷰를 표시합니다.
            reviewsWithCategory = self.combineReviewWithCategory()
        } else {
            // 선택한 카테고리에 따라 리뷰를 필터링합니다.
            reviewsWithCategory = self.combineReviewWithCategory().filter { $0.category.categoryName == selectedCategory }
        }
        
        self.reviewListCount.text = "\(reviewsWithCategory.count)"
        // 필터링된 리뷰를 표시하기 위해 테이블 뷰를 업데이트합니다.
        self.reviewListTableView.reloadData()
    }
    
    @IBAction func reviewWriteButton(_ sender: UIButton) {
        // ReviewWriteViewController로 이동하는 메서드 호출
        showReviewWriteViewController()
    }
    
    func showReviewWriteViewController() {
        // ReviewWriteViewController를 스토리보드에서 가져와서 푸시
        guard let reviewWriteVC = storyboard?.instantiateViewController(withIdentifier: "ReviewWrite") as? ReviewWriteViewController else { return }
        navigationController?.pushViewController(reviewWriteVC, animated: true)
    }
    
    // 피커뷰 설정
    func setupCategoryPickerView() {
        categoryPickerView = UIPickerView()
        categoryPickerView?.delegate = self
        categoryPickerView?.dataSource = self
        reviewCategoryTF.text = reviewCategorys[0]
        reviewCategoryTF.inputView = categoryPickerView
        createToolbar()
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "선택", style: .done, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        
        reviewCategoryTF.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped() {
        reviewCategoryTF.resignFirstResponder()
        filterReviewsByCategory()
    }
}

extension ReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}

extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsWithCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reviewListCell = tableView.dequeueReusableCell(withIdentifier: "reviewListCell", for: indexPath) as! ReviewListTableViewCell
        
        if indexPath.row < reviewsWithCategory.count {
            let review = reviewsWithCategory[indexPath.row].review
            let category = reviewsWithCategory[indexPath.row].category
            
            // 날짜 포맷팅
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
            
            if let date = dateFormatter.date(from: review.regDate) {
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let formattedDate = dateFormatter.string(from: date)
                reviewListCell.reviewListDateLabel.text = formattedDate
            } else {
                reviewListCell.reviewListDateLabel.text = "날짜 오류"
            }
            
            // 이미지 파일 이름을 바로 사용
//            let imageName = review.imageUrl
//            let image = UIImage(named: imageName)
//            reviewListCell.reviewListImageView.image = image
            
            reviewListCell.reviewListTextLabel.text = review.reviewContent
            
            reviewListCell.reviewListCategoryButton.setTitle("\(category.categoryName)", for: .normal)
            
            reviewListCell.reviewListNicknameLabel.text = review.userNickname
            
            // 별젘 이미지 뷰 채우기
            let rating = review.rating ?? 0.0 // 별점이 null인 경우를 고려
            for (index, imageView) in reviewListCell.reviewListStarRatingImageView.enumerated() {
                if Float(index) < rating {
                    imageView.image = UIImage(systemName: "star.fill")
                } else {
                    imageView.image = UIImage(systemName: "star")
                }
            }
        } else {
            print("인덱스값이 유효하지 않습니다.")
        }
        
        
        return reviewListCell
    }
}

extension ReviewViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return reviewCategorys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return reviewCategorys[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        reviewCategoryTF.text = reviewCategorys[row]
        selectedCategory = reviewCategorys[row]
    }
}
