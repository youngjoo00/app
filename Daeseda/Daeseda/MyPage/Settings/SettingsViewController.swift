import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
