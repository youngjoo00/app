import UIKit

class ReviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
}
