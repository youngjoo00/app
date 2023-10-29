import UIKit
import Alamofire

class SettingsViewController: UIViewController {
    
    var mainTabBarController: MainTabBarViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "설정"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            
        self.navigationItem.title = .none
    }
    
    @IBAction func ServiceButton(_ sender: UIButton) {
        // 1. 스토리보드에서 ServiceViewController의 식별자를 확인합니다.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let serviceVC = storyboard.instantiateViewController(withIdentifier: "Service") as? ServiceViewController {
            // 2. ServiceViewController의 인스턴스를 가져오는 부분을 수정합니다.
            serviceVC.modalTransitionStyle = .coverVertical
            // 3. serviceVC를 안전하게 처리하여 옵셔널 바인딩을 사용합니다.
            present(serviceVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func privacyPolicyButton(_ sender: UIButton) {
        // 1. 스토리보드에서 PrivacyPolicyViewController의 식별자를 확인합니다.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let privacyPolicyVC = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicy") as? PrivacyPolicyViewController {
            // 2. PrivacyPolicyViewController의 인스턴스를 가져오는 부분을 수정합니다.
            privacyPolicyVC.modalTransitionStyle = .coverVertical
            // 3. privacyPolicyVC를 안전하게 처리하여 옵셔널 바인딩을 사용합니다.
            present(privacyPolicyVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func CompanyInfoButton(_ sender: UIButton) {
        // 1. 스토리보드에서 CompanyInfoViewController의 식별자를 확인합니다.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let companyInfoVC = storyboard.instantiateViewController(withIdentifier: "CompanyInfo") as? CompanyInfoViewController {
            // 2. CompanyInfoViewController의 인스턴스를 가져오는 부분을 수정합니다.
            companyInfoVC.modalTransitionStyle = .coverVertical
            // 3. companyInfoVC를 안전하게 처리하여 옵셔널 바인딩을 사용합니다.
            present(companyInfoVC, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func userLogoutBtn(_ sender: UIButton) {
        let alertController = UIAlertController(title: "로그아웃", message: "정말 로그아웃 하시겠습니까?", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.performLogout()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func performLogout() {
        
        let url = "http://localhost:8888/users/logout"
        // 1. 토큰 가져오기
        if let token = UserTokenManager.shared.getToken() {
            print("Token: \(token)")
            
            // 2. Bearer Token을 설정합니다.
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            // 3. 서버에서 로그아웃 요청을 보냅니다.
            AF.request(url, method: .post, headers: headers).response { response in
                switch response.result {
                case .success:
                    // 요청이 성공한 경우
                    print("Logout Successful")
                    
                    // 4. 로컬에서 토큰을 삭제
                    UserTokenManager.shared.clearToken()
                    
                    // 5. 메인 탭바 뷰 컨트롤러의 showMyPage 함수 다시 실행
                    if let mainTabBarController = self.tabBarController as? MainTabBarViewController {
                        mainTabBarController.showPage()
                    }
                    
                    // 6. 현재 뷰 컨트롤러를 메인화면으로 팝
                    self.navigationController?.popToRootViewController(animated: true)
                    
                case .failure(let error):
                    // 요청이 실패한 경우
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Token not available.")
        }
    }
    
    @IBAction func userDelBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let showUserDelVC = storyboard.instantiateViewController(withIdentifier: "ShowUserDelVC") as? ShowUserDelViewController {
            showUserDelVC.modalTransitionStyle = .coverVertical
            present(showUserDelVC, animated: true, completion: nil)
        }
    }
}
