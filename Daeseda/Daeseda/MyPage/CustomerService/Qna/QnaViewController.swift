import UIKit
import Alamofire

class QnaViewController: UIViewController {
    
    @IBOutlet weak var qnaTableView: UITableView!
    
    var qnaList : [QnaListData] = []
    var comentList : [ComentData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qnaTableView.dataSource = self
        qnaTableView.delegate = self
        
        // 이 부분이 중요: 자동 높이 조절을 가능하게 설정
        qnaTableView.rowHeight = UITableView.automaticDimension
        qnaTableView.estimatedRowHeight = UITableView.automaticDimension
        
        let qnaWriteBarBtn = UIBarButtonItem(
            title: "게시글 작성",
            style: .plain,
            target: self,
            action: #selector(showQnaWriteBtn))
        navigationItem.rightBarButtonItem = qnaWriteBarBtn
        
        getQnaList()
        getComent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 화면이 나타날 때 리뷰 목록을 리로드
        getQnaList()
    }
    
    @objc func showQnaWriteBtn() {
        if let qnaWriteVC = self.storyboard?.instantiateViewController(withIdentifier: "QnaWrite") as? QnaWriteViewController {
            self.navigationController?.pushViewController(qnaWriteVC, animated: true)
        }
    }
    
    
    func getQnaList() {
        
        if let url = URL(string: "http://localhost:8888/board/list") {
            AF.request(url).responseDecodable(of: [QnaListData].self) { response in
                switch response.result {
                case .success(let data):
                    self.qnaList = data
                    self.qnaTableView.reloadData()
                case .failure(let error):
                    print("데이터 가져오기 실패: \(error)")
                }
            }
        }
    }
    
    func getComent() {
        if let url = URL(string: "http://localhost:8888/reply/list") {
            AF.request(url).responseDecodable(of: [ComentData].self) { response in
                switch response.result {
                case .success(let data):
                    self.comentList = data
                case .failure(let error):
                    print("데이터 가져오기 실패: \(error)")
                }
            }
        }
    }
}



// 날짜 및 시간을 포맷하는 함수
func formatDate(dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    } else {
        return "날짜 오류"
    }
}

func formatTime(timeString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    
    if let time = dateFormatter.date(from: timeString) {
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: time)
    } else {
        return "시간 오류"
    }
}


extension QnaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 네비게이션 컨트롤러를 이용하여 뷰 컨트롤러를 푸시(push)합니다.
        if let showQnaVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowQna") as? ShowQnaViewController {
            
            let qnaWriteData = qnaList[indexPath.row]
            
            showQnaVC.showQnaId = qnaWriteData.boardId
            self.navigationController?.pushViewController(showQnaVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


extension QnaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qnaList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let qnaCell = tableView.dequeueReusableCell(withIdentifier: "qnaCell", for: indexPath) as! QnaTableViewCell
        
        let qnaData = qnaList[indexPath.row]
        
        let matchingComents = comentList.filter { $0.boardId == qnaData.boardId }
        let comentCount = matchingComents.count
        
        qnaCell.titleLabel.text = qnaData.boardTitle
        qnaCell.dateLabel.text = formatDate(dateString: qnaData.regDate)
        qnaCell.comentLabel.text = "[\(comentCount)]"
        qnaCell.nicknameLabel.text = qnaData.userNickname
        qnaCell.timeLabel.text = formatTime(timeString: qnaData.regDate)
        
        return qnaCell
    }
}
