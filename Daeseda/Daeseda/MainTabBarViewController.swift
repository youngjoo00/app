import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        showPage()
    }

    func showPage() {
        print("showPage OK")
        // 메인, 주문 목록, 리뷰 뷰 컨트롤러를 먼저 생성
        let mainNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainNC")
        let orderListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderList")
        let reviewNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReviewNC")

        if let token = UserTokenManager.shared.getToken() {
            print("MainTabBarVC token : \(token)")
            // 토큰이 있는 경우 MypageUserVC를 표시
            let myPageUserNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MypageUserNC")
            setViewControllers([mainNC, orderListVC, reviewNC, myPageUserNC], animated: false)
        } else {
            // 토큰이 없는 경우 MypageGuestVC를 표시
            let myPageGuestNC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MypageGuestNC")
            setViewControllers([mainNC, orderListVC, reviewNC, myPageGuestNC], animated: false)
        }
    }

}
