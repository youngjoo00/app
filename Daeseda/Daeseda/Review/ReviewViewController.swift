import UIKit

class ReviewViewController: UIViewController {
    
    let reviews: Int = 2
    
    let reviewNicknames = [
        "피카츄",
        "도라에몽",
        "춘식이",
    ]
    
    let reviewDates = [
        "2023-01-01",
        "2023-02-02",
        "2023-03-03"
    ]
    
    let reviewImages = [
        "towel.jpg",
        "towel.jpg",
        "towel.jpg",
    ]
    
    let reviewTexts = [
        "반가와요^^",
        "댓글 테스트",
        "안녕하세요!"
    ]
    
    let reviewCategorys = [
        "생활빨래",
        "신발",
        "코트",
    ]
    
    let reviewStarRatings = [
        "5",
        "4",
        "3",
    ]
    
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
        let selectedNickname = reviewNicknames[indexPath.row]
        let selectedDate = reviewDates[indexPath.row]
        let selectedImageName = reviewImages[indexPath.row]
        let selectedText = reviewTexts[indexPath.row]
        let selectedCategory = reviewCategorys[indexPath.row]
        let selectedStarRating = reviewStarRatings[indexPath.row]
        
        print(selectedNickname, selectedDate, selectedImageName, selectedText, selectedCategory, selectedStarRating)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
}

extension ReviewViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewNicknames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reviewListCell = tableView.dequeueReusableCell(withIdentifier: "reviewListCell", for: indexPath) as! ReviewListTableViewCell
        
        reviewListCell.reviewListDateLabel.text = reviewDates[indexPath.row]
        
        // 이미지 파일 이름을 바로 사용
        let imageName = reviewImages[indexPath.row]
        let image = UIImage(named: imageName)
        reviewListCell.reviewListImageView.image = image
        
        print(imageName)
        print(reviewListCell)
        reviewListCell.reviewListTextLabel.text = reviewTexts[indexPath.row]
        
        // 버튼의 타이틀을 라벨 값으로 설정
        let selectedCategory = reviewCategorys[indexPath.row]
        reviewListCell.reviewListCategoryButton.setTitle(selectedCategory, for: .normal)
        
        reviewListCell.reviewListNicknameLabel.text = reviewNicknames[indexPath.row]
        
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
