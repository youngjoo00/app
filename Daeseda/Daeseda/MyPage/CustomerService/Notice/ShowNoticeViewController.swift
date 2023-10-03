import UIKit

class ShowNoticeViewController: UIViewController {

    @IBOutlet weak var noticeTitle: UILabel!
    @IBOutlet weak var noticeDate: UILabel!
    @IBOutlet weak var noticeText: UILabel!

    var noticeTitleString: String?
    var noticeDateString: String?
    var noticeTextString: String?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 이 곳에서 프로퍼티에 데이터를 할당하여 화면에 레이블에 표시할 수 있습니다.
        noticeTitle.text = noticeTitleString
        noticeDate.text = noticeDateString
        noticeText.text = noticeTextString
        
        print(noticeTitle.text ?? "default value")
        print(noticeDate.text ?? "default value")
        print(noticeText.text ?? "defalut value")
    }
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
