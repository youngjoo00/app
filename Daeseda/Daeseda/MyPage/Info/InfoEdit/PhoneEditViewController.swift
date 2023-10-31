import UIKit
import Alamofire

class PhoneEditViewController: UIViewController {
    
    var phoneData: String?
    let phoneNumberRegex = "^(01[0-9])-?([0-9]{3,4})-?([0-9]{4})$"
    var phoneLast: String?
    
    @IBOutlet weak var phoneEditCompleteBtn: UIButton!
    @IBOutlet weak var phoneEditTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 터치 제스처 추가: 키보드 외의 영역 터치 시 키보드 내리기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        // 텍스트 필드에 대한 이벤트 핸들러 설정
        phoneEditTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
        self.navigationItem.title = "전화번호 변경"
        
        updateButtonState()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = .none
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateButtonState()
        print(self.phoneEditTF.text!)
    }
    
    func updateButtonState() {
        if let phone = phoneEditTF.text {
            let isPhone = phone.range(of: phoneNumberRegex, options: .regularExpression) != nil
            if phone.isEmpty || phone == phoneData || !isPhone {
                phoneEditCompleteBtn.tintColor = UIColor.lightGray
                phoneEditCompleteBtn.isEnabled = false
            } else {
                phoneEditCompleteBtn.tintColor = UIColor(hex: 0x007AFF)
                phoneEditCompleteBtn.isEnabled = true
            }
            
            if isPhone {
                let formattedPhone = formatPhone(phone)
                phoneLast = formattedPhone
            }
        }
    }
    
    func patchPhone() {
        let endPoint = "/users/name"
        
        if let phone = phoneLast {
            let fullUrl = baseURL.baseURLString + endPoint
            
            // 1. 토큰 가져오기
            if let token = UserTokenManager.shared.getToken() {
                print("Token: \(token)")
                
                // 2. Bearer Token을 설정합니다.
                let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
                
                // 3. JSON 요청 본문 데이터 설정
                let parameters: [String: String] = ["userPhone": phone]
                
                // 4. 서버로 PATCH 요청 보내기
                AF.request(fullUrl, method: .patch, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
                    .validate(statusCode: 200..<300)
                    .response { response in
                        switch response.result {
                        case .success:
                            print("phone updated successfully")
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
    
    func formatPhone(_ phone: String) -> String {
        let formattedPhone = phone.replacingOccurrences(of: phoneNumberRegex, with: "$1-$2-$3", options: .regularExpression)
        return formattedPhone
    }


    
    @IBAction func phoneEditCompleteBtn(_ sender: UIButton) {
        patchPhone()
    }
    
    // 다른 영역 터치 시 키보드 내리기
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        phoneEditTF.resignFirstResponder() // 현재 First Responder 해제
    }
}
