//
//  JoinInfo1ViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/17.
//

import UIKit

class JoinInfo1ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.text = postId
        label()
        nextButton()
    }
    
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nicNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    
    @IBOutlet weak var passwordErrorMessage: UILabel!
    @IBOutlet weak var password2ErrorMessage: UILabel!
    
    
    var postId : String = "000000000"
    
    func label(){
        
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        title.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title.font = UIFont(name: "GmarketSansTTFMedium", size: 30)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        // Line height: 25 pt
        title.text = "Welcome!"

        self.view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.widthAnchor.constraint(equalToConstant: 300).isActive = true
        title.heightAnchor.constraint(equalToConstant: 50).isActive = true
        title.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 38).isActive = true
        title.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
        let subTitle = UILabel()
        subTitle.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        subTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        subTitle.font = UIFont(name: "GmarketSansTTFLight", size: 15)
        subTitle.numberOfLines = 0
        subTitle.lineBreakMode = .byWordWrapping
        // Line height: 25 pt
        subTitle.text = "양식에 맞추어 회원정보를 입력해주세요."

        self.view.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 38).isActive = true
        subTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        
        let id = UILabel()
        id.frame = CGRect(x: 0, y: 0, width: 80, height: 41)
        id.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        id.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        // Line height: 24.2 pt
        id.text = "아이디"
        
        self.view.addSubview(id)
        id.translatesAutoresizingMaskIntoConstraints = false
        id.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        id.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        
        let name = UILabel()
        name.frame = CGRect(x: 0, y: 0, width: 40, height: 41)
        name.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        // Line height: 24.2 pt
        name.text = "이름"
        
        self.view.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        name.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250).isActive = true
        
        let nickname = UILabel()
        nickname.frame = CGRect(x: 0, y: 0, width: 61.69, height: 42.29)
        nickname.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        nickname.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        // Line height: 24.2 pt
        nickname.text = "닉네임"
        
        self.view.addSubview(nickname)
        nickname.translatesAutoresizingMaskIntoConstraints = false
        nickname.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        nickname.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 300).isActive = true
        
        let password = UILabel()
        password.frame = CGRect(x: 0, y: 0, width: 80, height: 41)
        password.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        password.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        // Line height: 24.2 pt
        password.text = "비밀번호"
        
        self.view.addSubview(password)
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        password.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 410).isActive = true
        
        let checkPassword = UILabel()
        checkPassword.frame = CGRect(x: 0, y: 0, width: 131, height: 41)
        checkPassword.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        checkPassword.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        // Line height: 24.2 pt
        checkPassword.text = "비밀번호 확인"
        
        self.view.addSubview(checkPassword)
        checkPassword.translatesAutoresizingMaskIntoConstraints = false
        checkPassword.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        checkPassword.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 520).isActive = true
    }
    
    func nextButton(){
        let nextButton = UIButton()
        nextButton.frame = CGRect(x: 0, y: 0, width: 250, height: 34)
        nextButton.layer.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1).cgColor
        nextButton.layer.cornerRadius = 10
        
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        nextButton.addTarget(self, action: #selector(joinInfo2VC), for: .touchUpInside)
        
        
        let naxtText = UILabel()
        naxtText.frame = CGRect(x: 0, y: 0, width: 37, height: 27)
        naxtText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        naxtText.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        naxtText.textAlignment = .center
        naxtText.text = "다음"
        
        self.view.addSubview(naxtText)
        naxtText.translatesAutoresizingMaskIntoConstraints = false
        naxtText.widthAnchor.constraint(equalToConstant: 37).isActive = true
        naxtText.heightAnchor.constraint(equalToConstant: 27).isActive = true
        naxtText.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
        naxtText.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
    }
    
    @objc func joinInfo2VC() {
        guard  let joinInfo2VC = storyboard?.instantiateViewController(withIdentifier: "joinInfo2") as? JoinInfo2ViewController else { return }
        joinInfo2VC.userId = self.postId
        joinInfo2VC.userName = self.nameTextField.text!
        joinInfo2VC.userNicName = self.nicNameTextField.text!
        joinInfo2VC.userPassword = self.passwordTextField.text!
        joinInfo2VC.userEmail = self.postId

        self.navigationController?.pushViewController(joinInfo2VC, animated: true)
    }
}
extension JoinInfo1ViewController : UITextFieldDelegate {
    // 비밀번호 유효성 검사
    @IBAction func passwordTextFieldEditingChanged(_ sender: Any) {
        if let password = passwordTextField.text {
            let regex1 = try! NSRegularExpression(pattern: "(?=.*[A-Z])")
            let regex2 = try! NSRegularExpression(pattern: "(?=.*[a-z])")
            let regex3 = try! NSRegularExpression(pattern: "(?=.*[0-9])")
            let regex4 = try! NSRegularExpression(pattern: "(?=.*[!@#$%^&*()_+=-])")
            let regex5 = try! NSRegularExpression(pattern: ".{8,50}")
            
            // 대문자 검사
            let uppercaseMatch = regex1.firstMatch(in: password, range: NSRange(password.startIndex..., in: password))
            // 소문자 검사
            let lowercaseMatch = regex2.firstMatch(in: password, range: NSRange(password.startIndex..., in: password))
            // 숫자 검사
            let digitMatch = regex3.firstMatch(in: password, range: NSRange(password.startIndex..., in: password))
            // 특수문자 검사
            let specialCharacterMatch = regex4.firstMatch(in: password, range: NSRange(password.startIndex..., in: password))
            // 길이 검사
            let lengthMatch = regex5.firstMatch(in: password, range: NSRange(password.startIndex..., in: password))
            
            switch (uppercaseMatch, lowercaseMatch, digitMatch, specialCharacterMatch, lengthMatch) {
            case (nil, nil, nil, nil, nil):
                passwordErrorMessage.text = "대문자, 소문자, 숫자, 특수문자를 포함해주세요.(8~50자)"
            
            case (nil, nil, nil, _, nil):
                passwordErrorMessage.text = "대문자, 소문자, 숫자를 포함해주세요.(8~50자)"
            case (nil, nil, nil, _, _):
                passwordErrorMessage.text = "대문자, 소문자, 숫자를 포함해주세요."
            case (nil, nil, _, nil, nil):
                passwordErrorMessage.text = "대문자, 소문자, 특수문자를 포함해주세요.(8~50자)"
            case (nil, nil, _, nil, _):
                passwordErrorMessage.text = "대문자, 소문자, 특수문자를 포함해주세요."
            case (nil, _, nil, nil, nil):
                passwordErrorMessage.text = "대문자, 숫자, 특수문자를 포함해주세요.(8~50자)"
            case (nil, _, nil, nil, _):
                passwordErrorMessage.text = "대문자, 숫자, 특수문자를 포함해주세요."
            case (_, nil, nil, nil, nil):
                passwordErrorMessage.text = "소문자, 숫자, 특수문자를 포함해주세요.(8~50자)"
            case (_, nil, nil, nil, _):
                passwordErrorMessage.text = "소문자, 숫자, 특수문자를 포함해주세요."
            
                
            case (nil, nil, _, _, nil):
                passwordErrorMessage.text = "대문자, 소문자를 포함해주세요.(8~50자)"
            case (nil, nil, _, _, _):
                passwordErrorMessage.text = "대문자, 소문자를 포함해주세요."
            case (nil, _, nil, _, nil):
                passwordErrorMessage.text = "대문자, 숫자를 포함해주세요.(8~50자)"
            case (nil, _, nil, _, _):
                passwordErrorMessage.text = "대문자, 숫자를 포함해주세요."
            case (nil, _, _, nil, nil):
                passwordErrorMessage.text = "대문자, 특수문자를 포함해주세요.(8~50자)"
            case (nil, _, _, nil, _):
                passwordErrorMessage.text = "대문자, 특수문자를 포함해주세요."
            case (_, nil, nil, _, nil):
                passwordErrorMessage.text = "소문자, 숫자를 포함해주세요.(8~50자)"
            case (_, nil, nil, _, _):
                passwordErrorMessage.text = "소문자, 숫자를 포함해주세요."
            case (_, nil, _, nil, nil):
                passwordErrorMessage.text = "소문자, 특수문자를 포함해주세요.(8~50자)"
            case (_, nil, _, nil, _):
                passwordErrorMessage.text = "소문자, 특수문자를 포함해주세요."
            case (_, _, nil, nil, nil):
                passwordErrorMessage.text = "숫자, 특수문자를 포함해주세요.(8~50자)"
            case (_, _, nil, nil, _):
                passwordErrorMessage.text = "숫자, 특수문자를 포함해주세요."
                
            
            case (nil, _, _, _, nil):
                passwordErrorMessage.text = "대문자를 포함해주세요.(8~50자)"
            case (nil, _, _, _, _):
                passwordErrorMessage.text = "대문자를 포함해주세요."
            case (_, nil, _, _, nil):
                passwordErrorMessage.text = "소문자를 포함해주세요.(8~50자)"
            case (_, nil, _, _, _):
                passwordErrorMessage.text = "소문자를 포함해주세요."
            case (_, _, nil, _, nil):
                passwordErrorMessage.text = "숫자를 포함해주세요.(8~50자)"
            case (_, _, nil, _, _):
                passwordErrorMessage.text = "숫자를 포함해주세요."
            case (_, _, _, nil, nil):
                passwordErrorMessage.text = "특수문자를 포함해주세요.(8~50자)"
            case (_, _, _, nil, _):
                passwordErrorMessage.text = "특수문자를 포함해주세요."
            case (_, _, _, _, nil):
                passwordErrorMessage.text = "8자 이상 작성해주세요."
            default:
                passwordErrorMessage.text = " "
            }

        }
    }
    
    @IBAction func password2TextFieldDidEndOnExit(_ sender: Any) {
        if password2TextField.text != passwordTextField.text {
            password2ErrorMessage.text = "설정한 비밀번호와 일치하지 않습니다."
        } else {
            password2ErrorMessage.text = " "
        }
    }
    
}
