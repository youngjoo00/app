import UIKit
import Alamofire

class MyReviewViewController : UIViewController {
    
    let url = "http://localhost:8888/review/list"
    var myReviews: [ReviewData] = []
    
    @IBOutlet weak var myReviewCountLabel: UILabel!
    @IBOutlet weak var myReviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myReviewTableView.dataSource = self
        myReviewTableView.delegate = self
        
        myReviewTableView.rowHeight = UITableView.automaticDimension
        myReviewTableView.estimatedRowHeight = UITableView.automaticDimension
        
        getMyReviewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 탭 바를 숨깁니다.
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 다른 화면으로 이동할 때 탭 바를 다시 보이게 합니다.
        tabBarController?.tabBar.isHidden = false
    }
    
    func getMyReviewData() {
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        self.myReviews = try JSONDecoder().decode([ReviewData].self, from: data)
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
        let selectedCategory = "카테고리" // 실제 리뷰 데이터에서 카테고리 데이터를 사용하도록 수정
        myReviewsCell.myReviewCategoryBtn.setTitle(selectedCategory, for: .normal)
        
        myReviewsCell.myReviewNicknameLabel.text = "\(review.userId)"
        
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
