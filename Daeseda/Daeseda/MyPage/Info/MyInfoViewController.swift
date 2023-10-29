import UIKit
import Alamofire

class MyInfoViewController: UIViewController {
    
    let url = "http://localhost:8888/users/myInfo"

    var myInfoData: UserInfoData?
    
    @IBOutlet weak var myInfoTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myInfoTableView.delegate = self
        myInfoTableView.dataSource = self
        
        self.title = "내 정보 설정"

        if let navigationBar = self.navigationController?.navigationBar {
            let font = WDFont.GmarketBold.of(size: 30)
            navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        getMyInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 다른 화면으로 이동할 때 탭 바를 다시 보이게 합니다.
        tabBarController?.tabBar.isHidden = false
    }
    
    func getMyInfo() {
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
                    self.myInfoData = userInfo
                    self.myInfoTableView.reloadData()
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

extension MyInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            // 0번째 셀을 터치했을 때
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let nicknameEditVC = storyboard.instantiateViewController(withIdentifier: "NicknameEditVC") as? NicknameEditViewController {
                nicknameEditVC.nicknameData = myInfoData?.userNickname
                navigationController?.pushViewController(nicknameEditVC, animated: true)
            }
        } else if indexPath.row == 1 {
            // 2번째 셀을 터치했을 때
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let nameEditVC = storyboard.instantiateViewController(withIdentifier: "NameEditVC") as? NameEditViewController {
                nameEditVC.nameData = myInfoData?.userName
                navigationController?.pushViewController(nameEditVC, animated: true)
            }
        } else if indexPath.row == 2 {
            // 2번째 셀을 터치했을 때
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let phoneEditVC = storyboard.instantiateViewController(withIdentifier: "PhoneEditVC") as? PhoneEditViewController {
                phoneEditVC.phoneData = myInfoData?.userPhone
                navigationController?.pushViewController(phoneEditVC, animated: true)
            }
        }
    }

}

extension MyInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4 // 네 개의 셀을 표시할 것으로 가정
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let nicknameCell = tableView.dequeueReusableCell(withIdentifier: "nicknameCell", for: indexPath) as! NicknameTableViewCell
            nicknameCell.nicknameLabel.text = myInfoData?.userNickname
            return nicknameCell
        } else if indexPath.row == 1 {
            let nameCell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! NameTableViewCell
            nameCell.nameLabel.text = myInfoData?.userName
            return nameCell
        } else if indexPath.row == 2 {
            let phoneCell = tableView.dequeueReusableCell(withIdentifier: "phoneCell", for: indexPath) as! PhoneTableViewCell
            phoneCell.phoneLabel.text = myInfoData?.userPhone
            return phoneCell
        } else {
            let emailCell = tableView.dequeueReusableCell(withIdentifier: "emailCell", for: indexPath) as! EmailTableViewCell
            emailCell.emailLabel.text = myInfoData?.userEmail
            return emailCell
        }
    }
}
