import UIKit

class MypageUserViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMypageInfo()
        setupMypageButtons()
        

        // 타이틀 텍스트 폰트 조절
        if let navigationBar = self.navigationController?.navigationBar {
            let font = WDFont.GmarketBold.of(size: 30)
            navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
    }
    
    // MARK: - Mypage Info Setup
    
    private func createLabel(text: String, fontSize: CGFloat, topConstant: CGFloat) -> UILabel {
        let label = UILabel()
        label.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        label.font = UIFont(name: "NotoSans-Regular", size: fontSize)
        label.text = text
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.heightAnchor.constraint(equalToConstant: fontSize),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant)
        ])
        
        return label
    }
    
    private func setupMypageInfo() {
        _ = createLabel(text: "홍길동", fontSize: 25, topConstant: 120)
        _ = createLabel(text: "010-0000-0000", fontSize: 20, topConstant: 150)
        _ = createLabel(text: "서울시 노원구 초안산로 12", fontSize: 20, topConstant: 180)
    }
    
    // MARK: - Mypage Button Setup
    
    private func createButton(text: String, topConstant: CGFloat, action: Selector) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont(name: "NotoSans-Regular", size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        button.addTarget(self, action: action, for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 27),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 31),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: topConstant)
        ])
        
        return button
    }

    private func setupMypageButtons() {
        let buttonActions: [(String, CGFloat, Selector)] = [
            ("내 정보", 254, #selector(showMyInfoViewController)),
            ("주소 설정", 314, #selector(showMyAdressViewController)),
            ("내가 쓴 리뷰", 374, #selector(showMyReviewsViewController)),
            ("고객센터", 434, #selector(showCustomerServiceViewController)),
            ("설정", 494, #selector(showSettingsViewController))
        ]
        
        for (text, topConstant, action) in buttonActions {
            _ = createButton(text: text, topConstant: CGFloat(topConstant), action: action)
        }
        
        // 나머지 버튼들에 대한 처리도 위와 같이 추가합니다.
    }

    
    
    
    @objc func showMyInfoViewController() {
        guard let myInfoVC = storyboard?.instantiateViewController(withIdentifier: "MyInfo") as? MyInfoViewController else { return }
        // MyInfoViewController로 화면을 전환합니다.
        self.navigationController?.pushViewController(myInfoVC, animated: true)
    }
    
    @objc func showMyAdressViewController() {
        guard let myAdressVC = storyboard?.instantiateViewController(withIdentifier: "MyAdress") as? MyAdressViewController else { return }
        // MyAdressViewController로 화면을 전환합니다.
        self.navigationController?.pushViewController(myAdressVC, animated: true)
    }
    
    @objc func showMyReviewsViewController() {
        guard let myReviewsVC = storyboard?.instantiateViewController(withIdentifier: "MyReviews") as? MyReviewViewController else { return }
        // MyReviewsViewController로 화면을 전환합니다.
        self.navigationController?.pushViewController(myReviewsVC, animated: true)
    }
    
    @objc func showCustomerServiceViewController() {
        guard let CustomerServiceViewControllerVC = storyboard?.instantiateViewController(withIdentifier: "CustomerService") as? CustomerServiceViewController else { return }
        // CustomerServiceViewController로 화면을 전환합니다.
        self.navigationController?.pushViewController(CustomerServiceViewControllerVC, animated: true)
    }
    
    @objc func showSettingsViewController() {
        guard let SettingsViewControllerVC = storyboard?.instantiateViewController(withIdentifier: "Settings") as? SettingsViewController else { return }
        // CustomerServiceViewController로 화면을 전환합니다.
        self.navigationController?.pushViewController(SettingsViewControllerVC, animated: true)
    }
    
}

