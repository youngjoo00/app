import UIKit
import Alamofire

struct noticeData: Codable {
    var noticeId: Int
    var noticeCategory: String
    var noticeTitle: String
    var noticeContent: String
    var regDate: String
    var modDate: String
}

class NoticeViewController: UIViewController {
    
    let url: String = "http://localhost:8081/notice/list"
    var notices: [noticeData] = []
    
    @IBOutlet weak var noticeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noticeTableView.dataSource = self
        noticeTableView.delegate = self
        
        // 이 부분이 중요: 자동 높이 조절을 가능하게 설정
        noticeTableView.rowHeight = UITableView.automaticDimension
        noticeTableView.estimatedRowHeight = UITableView.automaticDimension
        
        getNoticeData()
    }
    
    func getNoticeData() {
        let getUrl = url
        
        AF.request(getUrl).responseDecodable(of: [noticeData].self) { response in
            switch response.result {
            case .success(let fetchedNotices):
                // fetchedNotices를 noticeId를 기준으로 내림차순 정렬
                self.notices = fetchedNotices.sorted(by: { $0.noticeId > $1.noticeId })
                self.noticeTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension NoticeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 대상 뷰 컨트롤러를 생성합니다.
        let showNoticeVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowNotice") as! ShowNoticeViewController
        
        // 대상 뷰 컨트롤러에 데이터를 전달합니다.
        let selectedNotice = notices[indexPath.row]
        
        showNoticeVC.noticeData = selectedNotice
        
        // 대상 뷰 컨트롤러를 화면에 표시합니다.
        self.present(showNoticeVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension NoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath) as! NoticeTableViewCell
        
        let notice = notices[indexPath.row]
        
        noticeCell.titleLabel.text = notice.noticeTitle
        noticeCell.dateLabel.text = formatDate(notice.modDate)
        print(notice.modDate)
        return noticeCell
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
