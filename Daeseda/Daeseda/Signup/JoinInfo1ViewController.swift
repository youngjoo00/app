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
        
        passwordTextField.isSecureTextEntry = true
        password2TextField.isSecureTextEntry = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "회원가입"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = .none
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
        id.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        // Line height: 24.2 pt
        id.text = "아이디"
        
        self.view.addSubview(id)
        id.translatesAutoresizingMaskIntoConstraints = false
        id.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        id.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        
        let name = UILabel()
        name.frame = CGRect(x: 0, y: 0, width: 40, height: 41)
        name.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        // Line height: 24.2 pt
        name.text = "이름"
        
        self.view.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        name.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 260).isActive = true
        
        let nickname = UILabel()
        nickname.frame = CGRect(x: 0, y: 0, width: 61.69, height: 42.29)
        nickname.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        nickname.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        // Line height: 24.2 pt
        nickname.text = "닉네임"
        
        self.view.addSubview(nickname)
        nickname.translatesAutoresizingMaskIntoConstraints = false
        nickname.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        nickname.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 320).isActive = true
        
        let password = UILabel()
        password.frame = CGRect(x: 0, y: 0, width: 80, height: 41)
        password.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        password.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        // Line height: 24.2 pt
        password.text = "비밀번호"
        
        self.view.addSubview(password)
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        password.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 410).isActive = true
        
        let checkPassword = UILabel()
        checkPassword.frame = CGRect(x: 0, y: 0, width: 131, height: 41)
        checkPassword.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        checkPassword.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        // Line height: 24.2 pt
        checkPassword.text = "비밀번호 확인"
        
        self.view.addSubview(checkPassword)
        checkPassword.translatesAutoresizingMaskIntoConstraints = false
        checkPassword.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        checkPassword.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 520).isActive = true
    }
    
    func nextButton(){
            let nextButton = UIButton()
            nextButton.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
            nextButton.layer.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1).cgColor
            nextButton.layer.cornerRadius = 20
            
            self.view.addSubview(nextButton)
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
            nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
            nextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
            nextButton.addTarget(self, action: #selector(joinInfo2VC), for: .touchUpInside)
            
            
            let naxtText = UILabel()
            naxtText.frame = CGRect(x: 0, y: 0, width: 300, height: 40)
            naxtText.textColor = UIColor.white
            naxtText.font = UIFont(name: "NotoSansKR-Bold", size: 20)
            // Line height: 27.24 pt
            naxtText.textAlignment = .center
            naxtText.text = "다음"
            
            self.view.addSubview(naxtText)
            naxtText.translatesAutoresizingMaskIntoConstraints = false
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
        let errorMessage = passwordMatch(passwordTextField.text!)
        
        passwordErrorMessage.text = errorMessage
    }
    
    @IBAction func password2TextFieldDidEndOnExit(_ sender: Any) {
        if password2TextField.text != passwordTextField.text {
            password2ErrorMessage.text = "설정한 비밀번호와 일치하지 않습니다."
        } else {
            password2ErrorMessage.text = " "
            nextButton()
        }
    }
    
}
