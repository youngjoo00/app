import UIKit
import Alamofire

class MyInfoViewController: UIViewController {
    
    let url = "http://localhost:8888/users/myInfo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMyInfo()
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
    
    func updateUI(with userInfo: UserInfoData) {
        // UI 요소 생성
        
        
        let idLabel = createLabel(text: "아이디", textColor: .black, font: UIFont.systemFont(ofSize: 16))
        
        let userIdLabel = createLabel(text: userInfo.userEmail, textColor: UIColor(red: 0.839, green: 0.839, blue: 0.839, alpha: 1), font: UIFont.systemFont(ofSize: 16))
        
        let nameLabel = createLabel(text: "이름", textColor: .black, font: UIFont.systemFont(ofSize: 16))
        
        let userNameLabel = createLabel(text: userInfo.userName, textColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), font: UIFont.systemFont(ofSize: 16))
        
        let nickNameLabel = createLabel(text: "닉네임", textColor: .black, font: UIFont.systemFont(ofSize: 16))
        
        let userNickNameLabel = createLabel(text: userInfo.userNickname, textColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), font: UIFont.systemFont(ofSize: 16))
        
        let phoneNumberLabel = createLabel(text: "휴대번호", textColor: .black, font: UIFont.systemFont(ofSize: 16))
        
        let userPhoneNumberLabel = createLabel(text: userInfo.userPhone, textColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), font: UIFont.systemFont(ofSize: 16))
        
        let editButton = createButton(title: "수정", backgroundColor: UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1), titleColor: .white, font: UIFont.systemFont(ofSize: 16), cornerRadius: 15)
        editButton.addTarget(self, action: #selector(showMyInfoEditViewController), for: .touchUpInside)
        
        
        let userIdField = createTextField(placeholder: "", placeholderTextColor: .gray, underlineColor: .black, font: UIFont.systemFont(ofSize: 16))
        
        // 이제 다음과 같이 함수를 호출하여 줄 뷰를 생성할 수 있습니다.
        let userIdUnderLine = createLineView(on: userIdLabel, color: .black, lineWidth: 1, topConstant: 25, leadingConstant: 0, widthConstant: 200, heightConstant: 1)
        let userNameUnderLine = createLineView(on: userNameLabel, color: .black, lineWidth: 1, topConstant: 25, leadingConstant: 0, widthConstant: 200, heightConstant: 1)
        let userNickNameUnderLine = createLineView(on: userNickNameLabel, color: .black, lineWidth: 1, topConstant: 25, leadingConstant: 0, widthConstant: 200, heightConstant: 1)
        let userPhoneNumberUnderLine = createLineView(on: userPhoneNumberLabel, color: .black, lineWidth: 1, topConstant: 25, leadingConstant: 0, widthConstant: 200, heightConstant: 1)
        
        
        // UI 요소의 제약 조건 설정 (Auto Layout)
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            userIdLabel.topAnchor.constraint(equalTo: idLabel.topAnchor),
            userIdLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 20),
            
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editButton.widthAnchor.constraint(equalToConstant: 100),
            
            userIdField.topAnchor.constraint(equalTo: idLabel.topAnchor),
            userIdField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            
            nameLabel.topAnchor.constraint(equalTo: idLabel.topAnchor, constant: 75),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            userNameLabel.topAnchor.constraint(equalTo: userIdLabel.topAnchor, constant: 75),
            userNameLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 20),
            
            nickNameLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 75),
            nickNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            userNickNameLabel.topAnchor.constraint(equalTo: userNameLabel.topAnchor, constant: 75),
            userNickNameLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 20),
            
            phoneNumberLabel.topAnchor.constraint(equalTo: nickNameLabel.topAnchor, constant: 75),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            
            userPhoneNumberLabel.topAnchor.constraint(equalTo: userNickNameLabel.topAnchor, constant: 75),
            userPhoneNumberLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 20),
        ])
    }
    
    // UI 요소를 생성하는 메서드들
    func createLabel(text: String, textColor: UIColor, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = font
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }
    
    func createButton(title: String, backgroundColor: UIColor, titleColor: UIColor, font: UIFont, cornerRadius: CGFloat) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.layer.cornerRadius = cornerRadius
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }
    
    func createTextField(placeholder: String, placeholderTextColor: UIColor, underlineColor: UIColor, font: UIFont) -> UITextField {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            .foregroundColor: placeholderTextColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .underlineColor: underlineColor,
            .font: font,
            .baselineOffset: 7
        ])
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        return textField
    }
    
    @objc func showMyInfoEditViewController() {
        guard let myInfoEditVC = storyboard?.instantiateViewController(withIdentifier: "MyInfoEdit") as? MyInfoEditViewController else { return }
        // MyInfoViewController로 화면을 전환합니다.
        self.navigationController?.pushViewController(myInfoEditVC, animated: true)
        
    }
    
    @objc func showMyInfoViewController() {
        guard let myInfoEditVC = storyboard?.instantiateViewController(withIdentifier: "MyInfoEdit") as? MyInfoEditViewController else {
            return
        }
        // MyInfoEditViewController로 화면을 전환합니다.
        navigationController?.pushViewController(myInfoEditVC, animated: true)
    }
    
}

func createLineView(on view: UIView, color: UIColor, lineWidth: CGFloat, topConstant: CGFloat, leadingConstant: CGFloat, widthConstant: CGFloat, heightConstant: CGFloat) -> UIView {
    let lineView = UIView()
    lineView.backgroundColor = color // 줄의 색상을 설정합니다.
    lineView.translatesAutoresizingMaskIntoConstraints = false // Autoresizing을 비활성화합니다.
    view.addSubview(lineView) // 뷰를 화면에 추가합니다.
    
    // NSLayoutConstraint를 사용하여 constraint를 설정합니다.
    
    // 줄의 위에서 topConstant만큼 떨어진 위치
    let topConstraint = NSLayoutConstraint(item: lineView, attribute: .top, relatedBy: .equal,
                                           toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: topConstant)
    
    // 줄의 왼쪽에서 leadingConstant만큼 떨어진 위치
    let leadingConstraint = NSLayoutConstraint(item: lineView, attribute: .leading, relatedBy: .equal,
                                               toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: leadingConstant)
    
    // 줄의 너비가 widthConstant
    let widthConstraint = NSLayoutConstraint(item: lineView, attribute: .width, relatedBy: .equal,
                                             toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: widthConstant)
    
    // 줄의 높이가 heightConstant (두께)
    let heightConstraint = NSLayoutConstraint(item: lineView, attribute: .height, relatedBy: .equal,
                                              toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: heightConstant)
    
    // NSLayoutConstraint를 뷰에 적용합니다.
    NSLayoutConstraint.activate([topConstraint, leadingConstraint, widthConstraint, heightConstraint])
    
    return lineView // 생성한 줄 뷰를 반환합니다.
}

