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
    @IBOutlet weak var qnaEditBtn: UIButton!
    @IBOutlet weak var qnaDelBtn: UIButton!
    
    
    var qnaList : [QnaListData] = []
    var comentList : [ComentData] = []
    var myInfo: UserInfoData?
    var qnaTitleString: String?
    var qnaDateString: String?
    var qnaTextString: String?
    var qnaTimeString: String?
    var qnaNicknameString: String?
    var qnaCategoryString: String?
    var qnaComentCountString: String?
    var showQnaId: Int?
    var originalStackViewBottomConstraint: NSLayoutConstraint?
    var isSettingMenuVisible = false
    var selectedComentIndex: Int?
    var isEditingComment = false  // 수정 중인 댓글 여부를 나타내는 플래그
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        comentTableView.dataSource = self
        comentTableView.delegate = self
        
        comentTableView.rowHeight = UITableView.automaticDimension
        comentTableView.estimatedRowHeight = UITableView.automaticDimension
        
        qnaEditBtn.isHidden = true
        qnaDelBtn.isHidden = true
        comentWritePostBtn.setTitle("등록", for: .normal)
        
        getQnaList()
        getMyInfoData()
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
        
        // 이전 데이터를 초기화
        qnaList.removeAll()
        comentList.removeAll()
        
        getQnaList()
        getComent()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 다른 화면으로 이동할 때 탭 바를 다시 보이게 합니다.
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func comentEditBtn(_ sender: UIButton) {
        // 버튼의 슈퍼뷰인 셀의 indexPath를 찾습니다.
        if let cell = sender.superview?.superview as? ComentTableViewCell,
           let indexPath = comentTableView.indexPath(for: cell) {
            selectedComentIndex = indexPath.row
            let comentToEdit = comentList[indexPath.row]
            let replyIdToEdit = comentToEdit.replyId
            print("comentToEdit : \(comentToEdit)")
            print("replyIdToEdit : \(replyIdToEdit)")
            
            isEditingComment = true
            comentWritePostBtn.setTitle("수정", for: .normal)  // "수정"으로 버튼 텍스트 변경
            comentWriteTF.text = comentList[indexPath.row].replyContent
            comentWriteTF.becomeFirstResponder()
            
            // replyIdToDelete을 사용하여 댓글 삭제 작업 수행
            // comentEditConfirmationAlert(replyId: replyIdToEdit)
        }
    }
    
    @IBAction func comentDelBtn(_ sender: UIButton) {
        // 버튼의 슈퍼뷰인 셀의 indexPath를 찾습니다.
        if let cell = sender.superview?.superview as? ComentTableViewCell,
           let indexPath = comentTableView.indexPath(for: cell) {
            let comentToDelete = comentList[indexPath.row]
            let replyIdToDelete = comentToDelete.replyId
            print("comentToDelte : \(comentToDelete)")
            print("replyIdToDelete : \(replyIdToDelete)")
            // replyIdToDelete을 사용하여 댓글 삭제 작업 수행
            comentDelConfirmationAlert(replyId: replyIdToDelete)
        }
    }
    
    func comentDelConfirmationAlert(replyId: Int) {
        let alertController = UIAlertController(title: "게시글 삭제", message: "정말 게시글을 삭제하시겠습니까?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.performComentDel(replyId: replyId)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func performComentDel(replyId: Int) {
        let url = "http://localhost:8888/reply/\(replyId)"
        
        if let token = UserTokenManager.shared.getToken() {
            print("Token: \(token)")
            
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            AF.request(url, method: .delete, headers: headers).response { response in
                switch response.result {
                case .success:
                    // 요청이 성공한 경우
                    print("Qna Deleted Successfully")
                    self.getComent()
                case .failure(let error):
                    // 요청이 실패한 경우
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Token not available.")
        }
        
    }
    
    @objc func showSettingMenu() {
        isSettingMenuVisible.toggle() // 상태 변수를 토글
        
        // UI 업데이트
        updateUI()
    }
    
    @IBAction func qnaEditBtnTouch(_ sender: UIButton) {
        // Storyboard에서 QnaEditVC의 스토리보드 식별자를 확인합니다.
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Main은 사용 중인 스토리보드 이름에 따라 변경하세요.
        
        if let qnaEditVC = storyboard.instantiateViewController(withIdentifier: "QnaEdit") as? QnaEditViewController {
            // QnaEditVC에 필요한 데이터를 전달 (예: qnaTitleString, qnaTextString 등)
            qnaEditVC.qnaEditTitle = qnaTitleString
            qnaEditVC.qnaEditContent = qnaTextString
            qnaEditVC.qnaEditCategory = qnaCategoryString
            qnaEditVC.qnaEditId = showQnaId
            
            // QnaEditVC로 화면 전환
            navigationController?.pushViewController(qnaEditVC, animated: true)
        }
    }
    
    
    @IBAction func qnaDelBtnTouch(_ sender: Any) {
        showDeleteConfirmationAlert()
    }
    
    func showDeleteConfirmationAlert() {
        let alertController = UIAlertController(title: "게시글 삭제", message: "정말 게시글을 삭제하시겠습니까?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.performQnaDel()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func performQnaDel() {
        if let showQnaId = showQnaId {
            let url = "http://localhost:8888/board/\(showQnaId)"
            
            if let token = UserTokenManager.shared.getToken() {
                print("Token: \(token)")
                
                let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
                
                AF.request(url, method: .delete, headers: headers).response { response in
                    switch response.result {
                    case .success:
                        // 요청이 성공한 경우
                        print("Qna Deleted Successfully")
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        // 요청이 실패한 경우
                        print("Error: \(error.localizedDescription)")
                    }
                }
            } else {
                print("Token not available.")
            }
        }
    }
    
    func getQnaList() {
        if let url = URL(string: "http://localhost:8888/board/list") {
            AF.request(url).responseDecodable(of: [QnaListData].self) { response in
                switch response.result {
                case .success(let data):
                    self.qnaList = data
                    self.matchShowQnaData()
                case .failure(let error):
                    print("데이터 가져오기 실패: \(error)")
                }
            }
        }
    }
    
    func matchShowQnaData() {
        if let showQnaId = showQnaId {
            if let matchedQna = qnaList.first(where: { $0.boardId == showQnaId }) {
                qnaTitleString = matchedQna.boardTitle
                qnaDateString = formatDate(dateString: matchedQna.regDate)
                qnaTextString = matchedQna.boardContent
                qnaTimeString = formatTime(timeString: matchedQna.regDate)
                qnaNicknameString = matchedQna.userNickname
                qnaCategoryString = matchedQna.boardCategory
                
                updateUI()
            }
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async { // 메인 스레드에서 실행
            self.qnaTitle.text = self.qnaTitleString
            self.qnaDate.text = self.qnaDateString
            self.qnaText.text = self.qnaTextString
            self.qnaTime.text = self.qnaTimeString
            self.qnaNickname.text = self.qnaNicknameString
            if let category = self.qnaCategoryString {
                self.qnaCategory.text = "[\(category)]"
            } else {
                self.qnaCategory.text = "[카테고리 없음]"
            }
            self.qnaComentCount.text = "댓글 " + (self.qnaComentCountString ?? "0")
            
            if let myNickname = self.myInfo?.userNickname {
                if myNickname == self.qnaNicknameString {
                    // 시스템 "ellipsis" 이미지를 사용
                    let ellipsisBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(self.showSettingMenu))
                    self.navigationItem.rightBarButtonItem = ellipsisBarButtonItem
                    
                    // 수정 및 삭제 버튼을 숨기거나 표시
                    self.qnaEditBtn.isHidden = !self.isSettingMenuVisible
                    self.qnaDelBtn.isHidden = !self.isSettingMenuVisible
                }
                
                if self.comentList.contains(where: { $0.userNickname == myNickname }) {
                    // 댓글 작성자가 현재 사용자와 동일한 경우 버튼을 표시
                    for (index, comentData) in self.comentList.enumerated() {
                        if comentData.userNickname == myNickname {
                            if let cell = self.comentTableView.cellForRow(at: IndexPath(row: index, section: 0)) as? ComentTableViewCell {
                                cell.comentDelBtn.isHidden = false
                                cell.comentEditBtn.isHidden = false
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    func getMyInfoData() {
        let url = "http://localhost:8888/users/myInfo"
        // 1. 토큰 가져오기
        if let token = UserTokenManager.shared.getToken() {
            print("Token: \(token)")
            
            // 2. Bearer Token을 설정합니다.
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            // 3. 서버에서 유저 정보를 가져오는 요청
            AF.request(url, headers: headers).responseDecodable(of: UserInfoData.self) { response in
                switch response.result {
                case .success(let userInfo):
                    // 요청이 성공한 경우
                    self.myInfo = userInfo
                    self.updateUI()
                case .failure(let error):
                    // 요청이 실패한 경우
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Token not available.")
        }
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
        if let index = selectedComentIndex {
            updateComentAtIndex(index)
            
        } else {
            createNewComent()
        }
        comentWriteTF.text = ""
        selectedComentIndex = nil
        
    }
    
    // 댓글 업데이트 함수
    func updateComentAtIndex(_ index: Int) {
        let comentToUpdate = comentList[index]
        let replyIdToUpdate = comentToUpdate.replyId
        
        guard let boardId = showQnaId,
              let replyContent = comentWriteTF.text else {
            showAlert("댓글 내용을 입력하세요.")
            return
        }
        
        let comentEditData = ComentEditData(replyId: replyIdToUpdate, boardId: boardId, replyContent: replyContent)
        
        print(comentEditData)
        
        let url = "http://localhost:8888/reply/\(replyIdToUpdate)"
        
        if let token = UserTokenManager.shared.getToken() {
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            AF.request(url, method: .put, parameters: comentEditData, encoder: JSONParameterEncoder.default, headers: headers)
                .response { response in
                    switch response.result {
                    case .success:
                        DispatchQueue.main.async {
                            self.comentWritePostBtn.setTitle("등록", for: .normal)
                        }
                        self.comentWriteTF.resignFirstResponder()
                        print("댓글 수정 성공")
                        self.getComent()
                    case .failure(let error):
                        print("Error: \(error.localizedDescription)")
                    }
                }
        } else {
            print("Token not available.")
        }
    }
    
    // 일반 댓글 작성 함수
    func createNewComent() {
        guard let replyContent = comentWriteTF.text, !replyContent.isEmpty,
              let boardId = showQnaId else {
            showAlert("댓글 내용을 입력하세요.")
            return
        }
        
        let comentData = ComentPostData(boardId: boardId, replyContent: replyContent)
        
        let comentPostUrl = "http://localhost:8888/reply/register"
        
        if let token = UserTokenManager.shared.getToken() {
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            AF.request(comentPostUrl, method: .post, parameters: comentData, encoder: JSONParameterEncoder.default, headers: headers)
                .response { response in
                    switch response.result {
                    case .success:
                        print("댓글 작성 성공")
                        self.getComent()
                    case .failure(let error):
                        print("댓글 작성 실패: \(error.localizedDescription)")
                    }
                }
        } else {
            print("Token not available.")
        }
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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
        if isEditingComment {
            let alertController = UIAlertController(title: "수정 취소", message: "수정 중인 댓글을 취소하시겠습니까?", preferredStyle: .alert)
            
            let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
                // "확인"을 눌렀을 때 실행할 코드 추가 (예: 편집 상태 초기화)
                self.isEditingComment = false
                self.comentWritePostBtn.setTitle("등록", for: .normal)
                self.comentWriteTF.text = ""
                self.comentWriteTF.resignFirstResponder()
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
                // "취소"를 눌렀을 때 실행할 코드 추가 (예: 아무 작업 없음)
            }
            
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        } else {
            comentWriteTF.resignFirstResponder() // 현재 First Responder 해제
        }
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
        
        if let myNickname = myInfo?.userNickname {
            print("myNickname :",myNickname)
            if coments.userNickname == myNickname {
                // 댓글 작성자가 현재 사용자와 동일한 경우 버튼을 표시
                comentCell.comentDelBtn.isHidden = false
                comentCell.comentEditBtn.isHidden = false
            } else {
                comentCell.comentDelBtn.isHidden = true
                comentCell.comentEditBtn.isHidden = true
            }
        }
        return comentCell
    }
}
