import UIKit

class NoticeViewController: UIViewController {
    
    let titles = [
        "설 연휴 배송 안내1",
        "설 연휴 배송 안내2",
        "설 연휴 배송 안내3",
    ]
    
    let dates = [
        "2023년 01월 01일",
        "2023년 02월 02일",
        "2023년 03월 03일"
    ]
    
    let texts = [
        "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.",
        
        "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.",
        
        "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.",
    ]
    
    @IBOutlet weak var noticeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noticeTableView.dataSource = self
        noticeTableView.delegate = self
        
        // 이 부분이 중요: 자동 높이 조절을 가능하게 설정
        noticeTableView.rowHeight = UITableView.automaticDimension
        noticeTableView.estimatedRowHeight = UITableView.automaticDimension
    }
}

extension NoticeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 대상 뷰 컨트롤러를 생성합니다.
        let showNoticeVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowNotice") as! ShowNoticeViewController
        
        // 대상 뷰 컨트롤러에 데이터를 전달합니다.
        showNoticeVC.noticeTitleString = titles[indexPath.row]
        showNoticeVC.noticeDateString = dates[indexPath.row]
        showNoticeVC.noticeTextString = texts[indexPath.row]
        
        print(showNoticeVC.noticeTitleString ?? "default value")
        print(showNoticeVC.noticeDateString ?? "default value")
        print(showNoticeVC.noticeTextString ?? "default value")
        
        // 대상 뷰 컨트롤러를 화면에 표시합니다.
        self.present(showNoticeVC, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension NoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noticeCell = tableView.dequeueReusableCell(withIdentifier: "noticeCell", for: indexPath) as! NoticeTableViewCell
        
        noticeCell.titleLabel.text = titles[indexPath.row]
        noticeCell.dateLabel.text = dates[indexPath.row]
        
        return noticeCell
    }
}
