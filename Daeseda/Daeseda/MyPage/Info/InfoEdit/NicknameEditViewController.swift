import UIKit
import Alamofire

class NicknameEditViewController: UIViewController {
    
    var nicknameData: String?
    @IBOutlet weak var nicknameEditCompleteBtn: UIButton!
    @IBOutlet weak var nicknameEditTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 터치 제스처 추가: 키보드 외의 영역 터치 시 키보드 내리기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        // 텍스트 필드에 대한 이벤트 핸들러 설정
        nicknameEditTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
        self.navigationItem.title = "닉네임 변경"
        
        updateButtonState()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = .none
    }
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateButtonState()
    }
    
    func updateButtonState() {
        if let nickname = nicknameEditTF.text {
            if nickname.isEmpty || nickname == nicknameData {
                // 조건 1: nicknameData와 nicknameEditTF.text가 동일하거나 비어있을 때
                nicknameEditCompleteBtn.tintColor = UIColor.lightGray
                nicknameEditCompleteBtn.isEnabled = false
            } else {
                // 조건 2: nicknameData와 nicknameEditTF.text가 동일하지 않고 비어있지 않을 때
                nicknameEditCompleteBtn.tintColor = UIColor(hex: 0x007AFF)
                nicknameEditCompleteBtn.isEnabled = true
            }
        }
    }
    
    func patchNickname() {
        let endPoint = "/users/nickname"
        
        if let nickname = nicknameEditTF.text {
            let fullURL = baseURL.baseURLString + endPoint
            
            // 1. 토큰 가져오기
            if let token = UserTokenManager.shared.getToken() {
                print("Token: \(token)")
                
                // 2. Bearer Token을 설정합니다.
                let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
                
                // 3. JSON 요청 본문 데이터 설정
                let parameters: [String: String] = ["userNickname": nickname]
                
                // 4. 서버로 PATCH 요청 보내기
                AF.request(fullURL, method: .patch, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
                    .validate(statusCode: 200..<300)
                    .response { response in
                        switch response.result {
                        case .success:
                            print("Nickname updated successfully")
                            self.navigationController?.popToRootViewController(animated: true)
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                    }
            } else {
                print("Token not available.")
            }
        }
    }
    
    
    @IBAction func nicknameEditCompleteBtn(_ sender: UIButton) {
        patchNickname()
    }
    
    // 다른 영역 터치 시 키보드 내리기
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        nicknameEditTF.resignFirstResponder() // 현재 First Responder 해제
    }
}
