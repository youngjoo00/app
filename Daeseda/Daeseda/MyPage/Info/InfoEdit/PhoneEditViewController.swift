import UIKit
import Alamofire

class PhoneEditViewController: UIViewController {

    var phoneData: String?
    
    @IBOutlet weak var phoneEditCompleteBtn: UIButton!
    @IBOutlet weak var phoneEditTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 텍스트 필드에 대한 이벤트 핸들러 설정
        phoneEditTF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateButtonState()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updateButtonState()
    }
    
    func updateButtonState() {
        if let phone = phoneEditTF.text {
            if phone.isEmpty || phone == phoneData {
                phoneEditCompleteBtn.tintColor = UIColor.lightGray
                phoneEditCompleteBtn.isEnabled = false
            } else {
                phoneEditCompleteBtn.tintColor = UIColor(hex: 0x007AFF)
                phoneEditCompleteBtn.isEnabled = true
            }
        }
    }
    
    func patchPhone() {
        if let phone = phoneEditTF.text {
            let url = "http://localhost:8888/users/name"
            
            // 1. 토큰 가져오기
            if let token = UserTokenManager.shared.getToken() {
                print("Token: \(token)")
                
                // 2. Bearer Token을 설정합니다.
                let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
                
                // 3. JSON 요청 본문 데이터 설정
                let parameters: [String: String] = ["userPhone": phone]
                
                // 4. 서버로 PATCH 요청 보내기
                AF.request(url, method: .patch, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
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
    
    
    @IBAction func phoneEditCompleteBtn(_ sender: UIButton) {
        patchPhone()
    }
   

}
