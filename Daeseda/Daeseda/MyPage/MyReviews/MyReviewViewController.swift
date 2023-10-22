import UIKit
import Alamofire

class MyReviewViewController: UIViewController {
    let url = "http://localhost:8888/review/list"
    var myReviews: [ReviewData] = []
    var myInfo: UserInfoData?
    
    var categoryPickerView: UIPickerView?
    var selectedCategory: String?
    
    let reviewCategorys = [
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
    
    @IBOutlet weak var myReviewCategoryTF: UITextField!
    @IBOutlet weak var myReviewCountLabel: UILabel!
    @IBOutlet weak var myReviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myReviewTableView.dataSource = self
        myReviewTableView.delegate = self
        
        myReviewTableView.rowHeight = UITableView.automaticDimension
        myReviewTableView.estimatedRowHeight = UITableView.automaticDimension
        
        setupCategoryPickerView()
        getMyInfoData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMyReviewData()
        // 탭 바를 숨깁니다.
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 다른 화면으로 이동할 때 탭 바를 다시 보이게 합니다.
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupCategoryPickerView() {
        categoryPickerView = UIPickerView()
        categoryPickerView?.delegate = self
        categoryPickerView?.dataSource = self
        myReviewCategoryTF.text = reviewCategorys[0]
        myReviewCategoryTF.inputView = categoryPickerView
        createToolbar()
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        
        myReviewCategoryTF.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonTapped() {
        myReviewCategoryTF.resignFirstResponder()
    }
    
    func getMyReviewData() {
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        self.myReviews = try JSONDecoder().decode([ReviewData].self, from: data)
                        self.matchReviewsWithUserInfo() // 사용자 정보와 리뷰를 일치시킴
                        self.myReviews.sort { $0.reviewId > $1.reviewId }
                        self.myReviewTableView.reloadData()
                        self.myReviewCountLabel.text = "\(self.myReviews.count)"
                    } catch {
                        print("Failed to decode reviews: \(error)")
                    }
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
    }
    
    func getMyInfoData() {
        let url = "http://localhost:8888/users/myInfo"
        // 1. 토큰 가져오기
        if let token = UserTokenManager.shared.getToken() {
            print("Token: \(token)")
            
            // 2. Bearer Token을 설정합니다.
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            // 3. 서버에서 유저 정보를 가져오는 요청
            AF.request(url, headers: headers).responseDecodable(of: UserInfoData.self) { response in
                switch response.result {
                case .success(let userInfo):
                    // 요청이 성공한 경우
                    self.myInfo = userInfo
                    self.getMyReviewData() // 사용자 정보를 가져온 후 리뷰 데이터를 가져오도록 수정
                case .failure(let error):
                    // 요청이 실패한 경우
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Token not available.")
        }
    }
    
    // 사용자 정보와 리뷰를 일치시키는 메서드
    func matchReviewsWithUserInfo() {
        if let myInfo = myInfo {
            var matchedReviews: [ReviewData] = []

            for review in myReviews {
                if myInfo.userNickname == review.userNickname {
                    matchedReviews.append(review)
                }
            }

            myReviews = matchedReviews
        }
    }
    
    @IBAction func myReviewDelBtn(_ sender: UIButton) {
        // 터치한 셀을 인식하여 값을 가져옴
        let cell = sender.superview?.superview as! MyReviewTableViewCell
        if let indexPath = myReviewTableView.indexPath(for: cell) {
            let reviewId = myReviews[indexPath.row].reviewId
            showDeleteConfirmationAlert(reviewId: reviewId)
        }
    }

    func showDeleteConfirmationAlert(reviewId: Int) {
        let alertController = UIAlertController(title: "리뷰 삭제", message: "정말 리뷰를 삭제하시겠습니까?", preferredStyle: .alert)

        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.performReviewDel(reviewId: reviewId)
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    func performReviewDel(reviewId: Int) {
        let url = "http://localhost:8888/review/\(reviewId)"
        
        // 1. 토큰 가져오기
        if let token = UserTokenManager.shared.getToken() {
            print("Token: \(token)")
            
            // 2. Bearer Token을 설정합니다.
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            // 3. 서버에서 리뷰 삭제 요청을 보냅니다.
            AF.request(url, method: .delete, headers: headers).response { response in
                switch response.result {
                case .success:
                    // 요청이 성공한 경우
                    print("Review Deleted Successfully")
                    // 리뷰 삭제 후 리뷰 목록을 업데이트
                    self.getMyReviewData()
                    
                case .failure(let error):
                    // 요청이 실패한 경우
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Token not available.")
        }
    }

}


extension MyReviewViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

extension MyReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myReviewsCell = tableView.dequeueReusableCell(withIdentifier: "myReviewsCell", for: indexPath) as! MyReviewTableViewCell
        
        let review = myReviews[indexPath.row] // myReviews 배열에서 리뷰 데이터를 가져옵니다.
        
        // 날짜 포맷팅
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        
        if let date = dateFormatter.date(from: review.regDate) {
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let formattedDate = dateFormatter.string(from: date)
            myReviewsCell.myReviewDateLabel.text = formattedDate
        } else {
            myReviewsCell.myReviewDateLabel.text = "날짜 오류"
        }
        
        // ReviewData의 구조에 따라서 이 부분을 수정해야 할 수 있습니다.
        let imageName = review.imageUrl
        let image = UIImage(named: imageName)
        myReviewsCell.myReviewImage.image = image
        
        myReviewsCell.myReviewTextLabel.text = review.reviewContent
        
        // 리뷰 데이터에서 실제 카테고리 데이터를 사용하도록 수정해야 합니다.
        let selectedCategory = review.categories // 실제 리뷰 데이터에서 카테고리 데이터를 사용하도록 수정
        myReviewsCell.myReviewCategoryBtn.setTitle(selectedCategory, for: .normal)
        
        myReviewsCell.myReviewNicknameLabel.text = review.userNickname
        
        let rating = review.rating ?? 0.0 // 리뷰 데이터에서 별점을 가져옵니다.
        
        for (index, imageView) in myReviewsCell.myReviewStarRating.enumerated() {
            if Float(index) < rating {
                imageView.image = UIImage(systemName: "star.fill")
            } else {
                imageView.image = UIImage(systemName: "star")
            }
        }
        
        return myReviewsCell
    }
}

extension MyReviewViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
        myReviewCategoryTF.text = reviewCategorys[row]
        selectedCategory = reviewCategorys[row]
    }
}
