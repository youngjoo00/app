import UIKit

class CustomerServiceViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func noticeButton(_ sender: UIButton) {
        // NoticeViewController의 스토리보드 ID를 사용하여 초기화
        if let noticeVC = storyboard?.instantiateViewController(withIdentifier: "Notice") as? NoticeViewController {
            // 네비게이션 컨트롤러에 푸시하여 화면 전환
            self.navigationController?.pushViewController(noticeVC, animated: true)
        }
    }
    
    @IBAction func faqButton(_ sender: UIButton) {
        // FaQViewController의 스토리보드 ID를 사용하여 초기화
        if let faqVC = storyboard?.instantiateViewController(withIdentifier: "Faq") as? FaqViewController {
            // 네비게이션 컨트롤러에 푸시하여 화면 전환
            self.navigationController?.pushViewController(faqVC, animated: true)
        }
    }
    
    @IBAction func qnaButton(_ sender: UIButton) {
        // QnAViewController의 스토리보드 ID를 사용하여 초기화
        if let qnaVC = storyboard?.instantiateViewController(withIdentifier: "Qna") as? QnaViewController {
            // 네비게이션 컨트롤러에 푸시하여 화면 전환
            self.navigationController?.pushViewController(qnaVC, animated: true)
        }
    }
}
