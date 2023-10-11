import UIKit

class ShowNoticeViewController: UIViewController {
    
    @IBOutlet weak var noticeTitle: UILabel!
    @IBOutlet weak var noticeDate: UILabel!
    @IBOutlet weak var noticeText: UILabel!
    
    var noticeData: noticeData?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let noticeData = noticeData {
            noticeTitle.text = noticeData.noticeTitle
            noticeDate.text = formatDate(noticeData.modDate)
            noticeText.text = noticeData.noticeContent
        }
        
    }
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func formatDate(_ dateStr: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
            if let date = dateFormatter.date(from: dateStr) {
                dateFormatter.dateFormat = "yyyy년 MM월 dd일"
                return dateFormatter.string(from: date)
            }
            return dateStr
        }
}
