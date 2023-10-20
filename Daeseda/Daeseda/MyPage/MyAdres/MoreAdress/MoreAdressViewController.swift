import UIKit
import Alamofire

class MoreAdressViewController: UIViewController {
    
    var indexPath: IndexPath?
    var address: String?
    var zonecode: String?
    var isHome: Bool?
    var isHomeButtonSelected = false
    var isOtherButtonSelected = false
    
    let url = "http://localhost:8888/users/address/create"
    
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
        
    }
    
    
    @IBAction func moreAdressCompleteBtn(_ sender: UIButton) {
        // 주소 등록에 필요한 데이터 생성
        if let nickname = moreAdressNicknameTF.text,
           let detailAddress = moreAdressTF.text,
           let roadAddress = moreAdressLabel.text {
            
            let addressData = AddressCreateData(addressName: nickname,
                                                addressRoad: roadAddress,
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
