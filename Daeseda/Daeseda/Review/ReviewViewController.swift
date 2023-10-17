import UIKit
import Alamofire

class ReviewViewController: UIViewController {
    
    let url = "http://localhost:8888/review/list"
    var reviews: [ReviewData] = []
    
    let allCategorys = [
        "전체",
        "생활빨래",
        "가방",
        "신발",
        "코트",
        "대형이불",
        "등등등1",
        "등등등2",
        "등등등3",
    ]
    
    @IBOutlet weak var reviewListTableView: UITableView!
    
    @IBOutlet weak var reviewCategoryButton: UIButton!
    @IBOutlet weak var reviewCategoryPickerView: UIPickerView!
    
    @IBOutlet weak var reviewListCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reviewListTableView.dataSource = self
        reviewListTableView.delegate = self
        
        reviewCategoryPickerView.delegate = self
        reviewCategoryPickerView.dataSource = self
        reviewCategoryPickerView.isHidden = true
        reviewListTableView.rowHeight = UITableView.automaticDimension
        reviewListTableView.estimatedRowHeight = UITableView.automaticDimension
        
        // 타이틀 텍스트 폰트 조절
        if let navigationBar = self.navigationController?.navigationBar {
            let font = WDFont.GmarketBold.of(size: 30)
            navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        
        getReviewData()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 화면이 나타날 때 리뷰 목록을 리로드
        getReviewData()
    }
    
    func getReviewData() {
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        self.reviews = try JSONDecoder().decode([ReviewData].self, from: data)
                        self.reviewListTableView.reloadData()
                        self.reviewListCount.text = "\(self.reviews.count)"
                    } catch {
                        print("Failed to decode reviews: \(error)")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    @IBAction func reviewWriteButton(_ sender: UIButton) {
        // ReviewWriteViewController로 이동하는 메서드 호출
        showReviewWriteViewController()
    }
    
    @IBAction func reviewCategoryBtn(_ sender: UIButton) {
        showCategoryPicker()
    }
    
    func showCategoryPicker() {
        reviewCategoryPickerView.isHidden = false
    }
    
    
    func showReviewWriteViewController() {
        // ReviewWriteViewController를 스토리보드에서 가져와서 푸시
        guard let reviewWriteVC = storyboard?.instantiateViewController(withIdentifier: "ReviewWrite") as? ReviewWriteViewController else { return }
        navigationController?.pushViewController(reviewWriteVC, animated: true)
    }
}

extension ReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reviewListCell = tableView.dequeueReusableCell(withIdentifier: "reviewListCell", for: indexPath) as! ReviewListTableViewCell
        
        let review = reviews[indexPath.row]
        print("review 데이터 : \(review)")
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
        let imageName = review.imageUrl
        let image = UIImage(named: imageName)
        reviewListCell.reviewListImageView.image = image
        
        reviewListCell.reviewListTextLabel.text = review.reviewContent
        
        // 버튼의 타이틀을 라벨 값으로 설정
        let selectedCategory = "category"
        reviewListCell.reviewListCategoryButton.setTitle(selectedCategory, for: .normal)
        
        reviewListCell.reviewListNicknameLabel.text = "\(review.userId)"
        
        // 별점 이미지 뷰 채우기
        let rating = review.rating ?? 0.0 // 별점이 null인 경우를 고려
        for (index, imageView) in reviewListCell.reviewListStarRatingImageView.enumerated() {
            if Float(index) < rating {
                imageView.image = UIImage(systemName: "star.fill")
            } else {
                imageView.image = UIImage(systemName: "star")
            }
        }
        
        return reviewListCell
    }
    
    
}

extension ReviewViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return allCategorys[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCategory = allCategorys[row]
        reviewCategoryButton.setTitle(selectedCategory, for: .normal)
        reviewCategoryPickerView.isHidden = true
    }
}


extension ReviewViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return allCategorys.count
    }
    
    
}
