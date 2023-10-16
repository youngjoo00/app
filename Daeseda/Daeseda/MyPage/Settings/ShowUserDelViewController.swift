import UIKit
import Alamofire

class ShowUserDelViewController: UIViewController {
    
    var mainTabBarController: MainTabBarViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func lastUserDelBtn(_ sender: UIButton) {
        
        let url = "http://localhost:8888/users/delete"
        
        // 1. 토큰 가져오기
        if let token = UserTokenManager.shared.getToken() {
            print("Token: \(token)")
            
            // 2. Bearer Token을 설정합니다.
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            // 3. 서버에서 삭제 요청을 보냅니다.
            AF.request(url, method: .delete, headers: headers).response { response in
                switch response.result {
                case .success:
                    // 요청이 성공한 경우
                    print("userDel Successful")
                    
                    // 토큰 삭제
                    UserTokenManager.shared.clearToken()
                    
                    if let mainTabBarController = self.presentingViewController as? MainTabBarViewController {
                        mainTabBarController.showPage()
                    } else {
                        print("MainTabBarViewController not found.")
                    }
                    
                    self.dismiss(animated: true, completion: nil)
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
