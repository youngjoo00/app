import Foundation
import UIKit

class MyPageGuestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func showLoginBtn(_ sender: UIButton) {
        if let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as? LoginViewController {
            navigationController?.pushViewController(loginVC, animated: true)
        }
    }
}
