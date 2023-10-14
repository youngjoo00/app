import UIKit
import Alamofire

struct addressCreateData : Codable {
    var addressName : String
    var addressDetail : String
    var addressZipcode : String
}

class MoreAdressViewController: UIViewController {
    
    var indexPath: IndexPath?
    var address: String?
    var zonecode: String?
    var isHome: Bool?
    var isHomeButtonSelected = false
    var isOtherButtonSelected = false
    
    let url = "http://localhost:8888/users/address/create"
    
    @IBOutlet weak var moreAdressStackView: UIStackView!
    @IBOutlet weak var moreAdressOtherBtn: UIButton!
    @IBOutlet weak var moreAdressHomeBtn: UIButton!
    @IBOutlet weak var moreAdressNicknameTF: UITextField!
    @IBOutlet weak var moreAdressTF: UITextField!
    @IBOutlet weak var moreAdressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreAdressNicknameTF.delegate = self
        moreAdressTF.delegate = self
        
        if let adress = address {
            moreAdressLabel.text = adress
        }
        
        // 배경을 터치했을 때 키보드 내리기 위한 UITapGestureRecognizer 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        view.addGestureRecognizer(tapGesture)
        
        removeBorderFromButton(moreAdressHomeBtn)
        removeBorderFromButton(moreAdressOtherBtn)
        
    }
    
    
    @IBAction func MoreAdressHomeBtn(_ sender: UIButton) {
        if isHomeButtonSelected {
            return
        }
        
        isHomeButtonSelected = true
        isOtherButtonSelected = false
        isHome = true
        addBorderToButton(moreAdressHomeBtn)
        removeBorderFromButton(moreAdressOtherBtn)
        
        moreAdressNicknameTF.isHidden = true
    }
    
    @IBAction func MoreAdressOtherBtn(_ sender: UIButton) {
        if isOtherButtonSelected {
            return
        }
        
        isHomeButtonSelected = false
        isOtherButtonSelected = true
        isHome = false
        addBorderToButton(moreAdressOtherBtn)
        removeBorderFromButton(moreAdressHomeBtn)
        
        moreAdressNicknameTF.isHidden = false
    }
    
    
    @IBAction func moreAdressCompleteBtn(_ sender: UIButton) {
        // 주소 등록에 필요한 데이터 생성
        if let nickname = moreAdressNicknameTF.text,
           let detailAddress = moreAdressTF.text,
           let labelText = moreAdressLabel.text {
            
            let addressData = addressCreateData(addressName: nickname,
                                                addressDetail: detailAddress,
                                                addressZipcode: zonecode ?? "")
            
            // 1. 토큰 가져오기
            if let token = UserTokenManager.shared.getToken() {
                print("Token: \(token)")
                
                // 2. Bearer Token을 설정합니다.
                let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
                
                // 3. 서버에 주소 등록 요청을 보냅니다.
                AF.request(url, method: .post, parameters: addressData, encoder: JSONParameterEncoder.default, headers: headers)
                    .validate(statusCode: 200..<300)
                    .response { response in
                        switch response.result {
                        case .success:
                            print("Address registration successful")
                            
                            // 주소 등록이 완료된 후
                            NotificationCenter.default.post(name: NSNotification.Name("AddressDataUpdated"), object: nil)

                            self.navigationController?.popToRootViewController(animated: true)
                            
                        case .failure(let error):
                            print("Error: \(error.localizedDescription)")
                        }
                    }
            } else {
                print("Token not available.")
            }
        }
        
        // 나머지 코드는 그대로 유지
        if let isHomeBtn = isHome {
            print("우리 집? : \(isHomeBtn)")
        }
        
        // MyAdressVC로 이동
        if let navigationController = self.navigationController {
            for viewController in navigationController.viewControllers {
                if let myAdressVC = viewController as? MyAdressViewController {
                    navigationController.popToViewController(myAdressVC, animated: true)
                    break
                }
            }
        }
    }
    
    
    @objc func handleBackgroundTap() {
        moreAdressNicknameTF.resignFirstResponder()
        moreAdressTF.resignFirstResponder()
    }
    
    func addBorderToButton(_ button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(red: 0.36, green: 0.55, blue: 0.95, alpha: 1.0).cgColor
        button.layer.cornerRadius = 5.0
    }
    
    func removeBorderFromButton(_ button: UIButton) {
        button.layer.borderWidth = 1.0 // 보더의 두께를 조절할 수 있습니다.
        button.layer.borderColor = UIColor.lightGray.cgColor // 보더의 색상을 설정할 수 있습니다.
        button.layer.cornerRadius = 5.0 // 버튼의 모서리를 둥글게 만듭니다.
    }
}

extension MoreAdressViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
