import UIKit
import Alamofire

class MypageUserViewController: UIViewController {
    
    let url = "http://localhost:8888/users/myInfo"
    
    @IBOutlet weak var myNicknameLabel: UILabel!
    @IBOutlet weak var myPhoneLabel: UILabel!
    @IBOutlet weak var myAddressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMyData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = "마이페이지"
        // 타이틀 텍스트 폰트 조절
        if let navigationBar = self.navigationController?.navigationBar {
            let font = WDFont.GmarketBold.of(size: 30)
            navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        getMyData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationItem.title = .none
    }
    func getMyData() {
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
                    self.updateUI(with: userInfo)
                    
                case .failure(let error):
                    // 요청이 실패한 경우
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Token not available.")
        }
    }
    
    // 유저 정보를 화면에 업데이트하는 메서드
    func updateUI(with userInfo: UserInfoData) {
        myNicknameLabel.text = userInfo.userNickname
        myPhoneLabel.text = userInfo.userPhone
        
        if let addressDto = userInfo.addressDto {
            do {
                let encoder = JSONEncoder()
                encoder.outputFormatting = .prettyPrinted
                let addressData = try encoder.encode(addressDto.addressDetail)
                if var addressJSON = String(data: addressData, encoding: .utf8) {
                    // 큰따옴표를 제거
                    addressJSON = String(addressJSON.dropFirst().dropLast())
                    myAddressLabel.text = addressJSON
                    print(addressJSON)
                }
            } catch {
                print("Failed to encode addressDto to JSON: \(error.localizedDescription)")
                myAddressLabel.text = "기본주소가 설정되어 있지 않습니다."
            }
        } else {
            myAddressLabel.text = "기본주소가 설정되어 있지 않습니다."
        }
    }

    
    
    
    @IBAction func showMyInfoViewController() {
        guard let myInfoVC = storyboard?.instantiateViewController(withIdentifier: "MyInfo") as? MyInfoViewController else { return }
        // MyInfoViewController로 화면을 전환합니다.
        self.navigationController?.pushViewController(myInfoVC, animated: true)
    }
    
    @IBAction func showMyAdressViewController() {
        guard let myAdressVC = storyboard?.instantiateViewController(withIdentifier: "MyAdress") as? MyAdressViewController else { return }
        // MyAdressViewController로 화면을 전환합니다.
        self.navigationController?.pushViewController(myAdressVC, animated: true)
    }
    
    @IBAction func showMyReviewsViewController() {
        guard let myReviewsVC = storyboard?.instantiateViewController(withIdentifier: "MyReviews") as? MyReviewViewController else { return }
        // MyReviewsViewController로 화면을 전환합니다.
        self.navigationController?.pushViewController(myReviewsVC, animated: true)
    }
    
    @IBAction func showCustomerServiceViewController() {
        guard let CustomerServiceViewControllerVC = storyboard?.instantiateViewController(withIdentifier: "CustomerService") as? CustomerServiceViewController else { return }
        // CustomerServiceViewController로 화면을 전환합니다.
        self.navigationController?.pushViewController(CustomerServiceViewControllerVC, animated: true)
    }
    
    @IBAction func showSettingsViewController() {
        guard let SettingsViewControllerVC = storyboard?.instantiateViewController(withIdentifier: "Settings") as? SettingsViewController else { return }
        // CustomerServiceViewController로 화면을 전환합니다.
        self.navigationController?.pushViewController(SettingsViewControllerVC, animated: true)
    }
    
}

