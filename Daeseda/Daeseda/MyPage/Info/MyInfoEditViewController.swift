//import UIKit
//
//class MyInfoEditViewController: UIViewController {
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupUI()
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        tabBarController?.tabBar.isHidden = true
//    }
//
//    func setupUI() {
//        // UI 요소 생성
//        let idLabel = createLabel(text: "아이디", textColor: .black, font: UIFont.systemFont(ofSize: 16))
//
//        let userIdLabel = createLabel(text: "youngjoo@naver.com", textColor: UIColor(red: 0.839, green: 0.839, blue: 0.839, alpha: 1), font: UIFont.systemFont(ofSize: 16))
//
//        let nameLabel = createLabel(text: "이름", textColor: .black, font: UIFont.systemFont(ofSize: 16))
//
//        let userNameLabel = createLabel(text: "권영주", textColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), font: UIFont.systemFont(ofSize: 16))
//
//        let nickNameLabel = createLabel(text: "닉네임", textColor: .black, font: UIFont.systemFont(ofSize: 16))
//
//        let isNickNameUniqueButton = createButton(title: "중복확인", backgroundColor: .white, titleColor: .black, font: UIFont.systemFont(ofSize: 13), cornerRadius: 15)
//
//        let userNickNameTextField = createTextField(placeholder: "닉네임을 입력하세요", placeholderTextColor: .gray, underlineColor: .clear, font: UIFont.systemFont(ofSize: 16))
//
//        let emailLabel = createLabel(text: "이메일", textColor: .black, font: UIFont.systemFont(ofSize: 16))
//
//        let isEmailUniqueButton = createLabel(text: "인증번호받기", textColor: UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1), font: UIFont.systemFont(ofSize: 13))
//
//        let userEmailTextField = createTextField(placeholder: "이메일을 입력하세요", placeholderTextColor: .gray, underlineColor: .clear, font: UIFont.systemFont(ofSize: 16))
//
//        let emailConfirmLabel = createLabel(text: "인증번호", textColor: .black, font: UIFont.systemFont(ofSize: 16))
//
//        let isEmailConfirmButton = createButton(title: "확인", backgroundColor: .white, titleColor: .black, font: UIFont.systemFont(ofSize: 13), cornerRadius: 0)
//
//        let userEmailConfirmTextField = createTextField(placeholder: "인증번호를 입력하세요", placeholderTextColor: .gray, underlineColor: .clear, font: UIFont.systemFont(ofSize: 16))
//
//        let phoneNumberLabel = createLabel(text: "휴대번호", textColor: .black, font: UIFont.systemFont(ofSize: 16))
//
//        let isPhoneNumberUniqueButton = createButton(title: "인증번호받기", backgroundColor: .white, titleColor: .black, font: UIFont.systemFont(ofSize: 13), cornerRadius: 0)
//
//        let completeButton = createButton(title: "완료", backgroundColor: UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1), titleColor: .white, font: UIFont.systemFont(ofSize: 16), cornerRadius: 15)
//
//        let phoneNumberTextField = createTextField(placeholder: "010", placeholderTextColor: .gray, underlineColor: .clear, font: UIFont.systemFont(ofSize: 16))
//
//        let userPhoneNumberTextField = createTextField(placeholder: "", placeholderTextColor: .gray, underlineColor: .clear, font: UIFont.systemFont(ofSize: 16))
//
//        let phoneNumberConfirmLabel = createLabel(text: "인증번호", textColor: .black, font: UIFont.systemFont(ofSize: 16))
//
//        let isPhoneNumberConfirmButton = createButton(title: "확인", backgroundColor: .white, titleColor: .black, font: UIFont.systemFont(ofSize: 13), cornerRadius: 0)
//
//        let userPhoneNumberConfirmTextField = createTextField(placeholder: "인증번호를 입력하세요", placeholderTextColor: .gray, underlineColor: .clear, font: UIFont.systemFont(ofSize: 16))
//
//
//
//
//
////        let userPhoneNumberUnderLine = createLineView(on: userPhoneNumberLabel, color: .black, lineWidth: 1, topConstant: 25, leadingConstant: 0, widthConstant: 200, heightConstant: 1)
//
//
//        // UI 요소의 제약 조건 설정 (Auto Layout)
//        NSLayoutConstraint.activate([
//
//            // Label
//            idLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
//            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//
//            userIdLabel.topAnchor.constraint(equalTo: idLabel.topAnchor),
//            userIdLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 20),
//
//            nameLabel.topAnchor.constraint(equalTo: idLabel.topAnchor, constant: 50),
//            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//
//            userNameLabel.topAnchor.constraint(equalTo: userIdLabel.topAnchor, constant: 50),
//            userNameLabel.leadingAnchor.constraint(equalTo: idLabel.trailingAnchor, constant: 20),
//
//            nickNameLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 50),
//            nickNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//
//            emailLabel.topAnchor.constraint(equalTo: nickNameLabel.topAnchor, constant: 75),
//            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//
//            emailConfirmLabel.topAnchor.constraint(equalTo: emailLabel.topAnchor, constant: 75),
//            emailConfirmLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//
//            phoneNumberLabel.topAnchor.constraint(equalTo: emailConfirmLabel.topAnchor, constant: 75),
//            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//
//            phoneNumberConfirmLabel.topAnchor.constraint(equalTo: phoneNumberLabel.topAnchor, constant: 75),
//            phoneNumberConfirmLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
//
//            // Button
//            completeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
//            completeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            completeButton.widthAnchor.constraint(equalToConstant: 100),
//
//            isNickNameUniqueButton.topAnchor.constraint(equalTo: nickNameLabel.topAnchor, constant: -5),
//            isNickNameUniqueButton.leadingAnchor.constraint(equalTo: nickNameLabel.trailingAnchor, constant: 200),
//
//            isEmailUniqueButton.topAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -5),
//            isEmailUniqueButton.leadingAnchor.constraint(equalTo: emailLabel        .trailingAnchor, constant: 200),
//
//            isEmailConfirmButton.topAnchor.constraint(equalTo: userEmailConfirmTextField.topAnchor, constant: 0),
//            isEmailConfirmButton.leadingAnchor.constraint(equalTo: userEmailConfirmTextField        .trailingAnchor, constant: 20),
//
//            isPhoneNumberUniqueButton.topAnchor.constraint(equalTo: phoneNumberLabel.topAnchor, constant: -5),
//            isPhoneNumberUniqueButton.leadingAnchor.constraint(equalTo: phoneNumberLabel        .trailingAnchor, constant: 185),
//
//            isPhoneNumberConfirmButton.topAnchor.constraint(equalTo: userPhoneNumberConfirmTextField.topAnchor, constant: 0),
//            isPhoneNumberConfirmButton.leadingAnchor.constraint(equalTo: userPhoneNumberConfirmTextField        .trailingAnchor, constant: 20),
//
//            // textField
//            userNickNameTextField.topAnchor.constraint(equalTo: nickNameLabel.topAnchor, constant: 25),
//            userNickNameTextField.leadingAnchor.constraint(equalTo: nickNameLabel.leadingAnchor, constant: -5),
//            userNickNameTextField.widthAnchor.constraint(equalToConstant: 275),
//
//            userEmailTextField.topAnchor.constraint(equalTo: emailLabel.topAnchor, constant: 25),
//            userEmailTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor, constant: -5),
//            userEmailTextField.widthAnchor.constraint(equalToConstant: 275),
//
//            userEmailConfirmTextField.topAnchor.constraint(equalTo: emailConfirmLabel.topAnchor, constant: 25),
//            userEmailConfirmTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor, constant: -5),
//            userEmailConfirmTextField.widthAnchor.constraint(equalToConstant: 275),
//
//            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.topAnchor, constant: 25),
//            phoneNumberTextField.leadingAnchor.constraint(equalTo: phoneNumberLabel.leadingAnchor, constant: -5),
//            phoneNumberTextField.widthAnchor.constraint(equalToConstant: 45),
//
//            userPhoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberTextField.topAnchor, constant: 0),
//            userPhoneNumberTextField.leadingAnchor.constraint(equalTo: phoneNumberTextField.trailingAnchor, constant: 10),
//            userPhoneNumberTextField.widthAnchor.constraint(equalToConstant: 225),
//
//            userPhoneNumberConfirmTextField.topAnchor.constraint(equalTo: phoneNumberConfirmLabel.topAnchor, constant: 25),
//            userPhoneNumberConfirmTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor, constant: -5),
//            userPhoneNumberConfirmTextField.widthAnchor.constraint(equalToConstant: 275),
//        ])
//    }
//
//    // UI 요소를 생성하는 메서드들
//    func createLabel(text: String, textColor: UIColor, font: UIFont) -> UILabel {
//        let label = UILabel()
//        label.text = text
//        label.textColor = textColor
//        label.font = font
//        label.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(label)
//        return label
//    }
//
//    func createButton(title: String, backgroundColor: UIColor, titleColor: UIColor, font: UIFont, cornerRadius: CGFloat) -> UIButton {
//        let button = UIButton()
//        button.setTitle(title, for: .normal)
//        button.backgroundColor = backgroundColor
//        button.setTitleColor(titleColor, for: .normal)
//        button.titleLabel?.font = font
//        button.layer.cornerRadius = cornerRadius
//        button.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(button)
//        return button
//    }
//
//    func createTextField(placeholder: String, placeholderTextColor: UIColor, underlineColor: UIColor, font: UIFont) -> UITextField {
//        let textField = UITextField()
//        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
//            .foregroundColor: placeholderTextColor,
//            .font: font,
//            .baselineOffset: 7
//        ])
//        textField.borderStyle = .roundedRect // 텍스트 필드의 스타일을 .roundedRect로 설정합니다.
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(textField)
//        return textField
//    }
//
//}
//
