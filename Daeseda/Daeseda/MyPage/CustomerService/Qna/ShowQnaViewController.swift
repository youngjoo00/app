import UIKit
import Alamofire

class ShowQnaViewController: UIViewController {
    
    @IBOutlet weak var comentWritePostBtn: UIButton!
    @IBOutlet weak var comentWriteTF: UITextField!
    @IBOutlet weak var comentWriteStackView: UIStackView!
    @IBOutlet weak var comentTableView: UITableView!
    @IBOutlet weak var qnaTitle: UILabel!
    @IBOutlet weak var qnaDate: UILabel!
    @IBOutlet weak var qnaText: UILabel!
    @IBOutlet weak var qnaTime: UILabel!
    @IBOutlet weak var qnaNickname: UILabel!
    @IBOutlet weak var qnaComentCount: UILabel!
    @IBOutlet weak var qnaCategory: UILabel!
    
    var comentList : [ComentData] = []
    var qnaTitleString: String?
    var qnaDateString: String?
    var qnaTextString: String?
    var qnaTimeString: String?
    var qnaNicknameString: String?
    var qnaCategoryString: String?
    var qnaComentCountString: String?
    var showQnaId: Int?
    var originalStackViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        
        comentTableView.dataSource = self
        comentTableView.delegate = self
        
        comentTableView.rowHeight = UITableView.automaticDimension
        comentTableView.estimatedRowHeight = UITableView.automaticDimension
        
        getComent()
        
        // 키보드 관련 알림을 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // 터치 제스처 추가: 키보드 외의 영역 터치 시 키보드 내리기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        // 초기 `UIStackView`의 bottom 제약을 저장
        originalStackViewBottomConstraint = comentWriteStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        originalStackViewBottomConstraint?.isActive = true
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
    
    func updateUI() {
        qnaTitle.text = qnaTitleString
        qnaDate.text = qnaDateString
        qnaText.text = qnaTextString
        qnaTime.text = qnaTimeString
        qnaNickname.text = qnaNicknameString
        qnaCategory.text = qnaCategoryString
        qnaComentCount.text = "댓글 " + (qnaComentCountString ?? "0")
    }
    
    func getComent() {
        if let url = URL(string: "http://localhost:8888/reply/list") {
            AF.request(url).responseDecodable(of: [ComentData].self) { response in
                switch response.result {
                case .success(let data):
                    self.comentList = data.filter { $0.boardId == self.showQnaId }
                    self.qnaComentCountString = "\(self.comentList.count)"
                    self.updateUI()
                    self.comentTableView.reloadData()
                case .failure(let error):
                    print("데이터 가져오기 실패: \(error)")
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
    
    
    @IBAction func comentWritePostBtn(_ sender: UIButton) {
        let comentPostUrl = "http://localhost:8888/reply/register"
        
        // 텍스트 필드에서 값을 가져와서 ComentPostData 구조체에 할당
        guard let replyContent = comentWriteTF.text, !replyContent.isEmpty,
              let boardId = showQnaId
        else {
            print("모든 필드를 채워주세요.")
            return
        }
        
        let comentData = ComentPostData(boardId: boardId, replyContent: replyContent)
        
        if let token = UserTokenManager.shared.getToken() {
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            AF.request(comentPostUrl, method: .post, parameters: comentData, encoder: JSONParameterEncoder.default, headers: headers)
                .response { response in
                    switch response.result {
                    case .success:
                        print("등록 성공")
                        self.getComent()
                    case .failure(let error):
                        print("등록 실패: \(error.localizedDescription)")
                    }
                }
        } else {
            print("Token not available.")
        }
        comentWriteTF.resignFirstResponder() // 현재 First Responder 해제
        comentWriteTF.text = ""
    }

    

    
    // 키보드가 나타날 때 스택 뷰를 올림
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // 키보드가 나타날 때 스택 뷰의 bottom 제약을 조정
            originalStackViewBottomConstraint?.constant = -keyboardSize.height
        }
    }
    
    // 키보드가 사라질 때 스택 뷰를 내림
    @objc func keyboardWillHide(notification: NSNotification) {
        // 키보드가 사라질 때 스택 뷰의 bottom 제약을 원래 위치로 복원
        originalStackViewBottomConstraint?.constant = 0
    }
    
    // 다른 영역 터치 시 키보드 내리기
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        comentWriteTF.resignFirstResponder() // 현재 First Responder 해제
    }
    
}

extension ShowQnaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 네비게이션 컨트롤러를 이용하여 뷰 컨트롤러를 푸시(push)합니다.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}


extension ShowQnaViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comentCell = tableView.dequeueReusableCell(withIdentifier: "comentCell", for: indexPath) as! ComentTableViewCell
        
        let coments = comentList[indexPath.row]
        
        comentCell.comentDateLabel.text = formatDate(dateString: coments.regDate)
        comentCell.comentTextLabel.text = coments.replyContent
        comentCell.comentNicknameLabel.text = coments.userNickname
        comentCell.comentTimeLabel.text = formatTime(timeString: coments.regDate)
        
        return comentCell
    }
}
