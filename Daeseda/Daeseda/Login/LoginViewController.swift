//
//  LoginViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/16.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton()
        joinButton()
        forgetButton()
    }
    

    func loginButton(){
        let loginButton = UIButton()
        loginButton.frame = CGRect(x: 0, y: 0, width: 250, height: 34)
        loginButton.layer.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1).cgColor
        loginButton.layer.cornerRadius = 10

        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70).isActive = true
        loginButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 512).isActive = true
        
        // Auto layout, variables, and unit scale are not yet supported
        let loginLabel = UILabel()
        loginLabel.frame = CGRect(x: 0, y: 0, width: 56, height: 27)
        loginLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        loginLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        loginLabel.textAlignment = .center
        loginLabel.text = "로그인"

        self.view.addSubview(loginLabel)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.widthAnchor.constraint(equalToConstant: 56).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor).isActive = true
        loginLabel.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor).isActive = true
    }
    
    func joinButton(){
        let joinButton = UIButton()
        joinButton.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        joinButton.setTitle("회원가입→", for: .normal) // 버튼 텍스트 설정
        joinButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        joinButton.titleLabel?.font = UIFont(name: "NotoSans-Regular", size: 10)
        joinButton.addTarget(self, action: #selector(joinAgree), for: .touchUpInside)

        self.view.addSubview(joinButton)
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        joinButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        joinButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        joinButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 235).isActive = true
        joinButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 474).isActive = true
    }
    
    @objc func joinAgree() {
        guard  let joinAgreeVC = storyboard?.instantiateViewController(withIdentifier: "joinAgree") as? JoinAgreeViewController else { return }
        self.navigationController?.pushViewController(joinAgreeVC, animated: true)
    }
    
    func forgetButton(){
        
        let idForgetButton = UIButton()
        idForgetButton.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        idForgetButton.setTitle("아이디 찾기", for: .normal)
        idForgetButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        idForgetButton.titleLabel?.font = UIFont(name: "NotoSans-Regular", size: 10)
        idForgetButton.titleLabel?.textAlignment = .center
        idForgetButton.contentHorizontalAlignment = .center
        idForgetButton.contentVerticalAlignment = .center
        idForgetButton.underLineText() // 버튼 텍스트에 밑줄을 추가하는 사용자 지정 확장 메서드 호출
        idForgetButton.addTarget(self, action: #selector(idFind), for: .touchUpInside)

        self.view.addSubview(idForgetButton)
        idForgetButton.translatesAutoresizingMaskIntoConstraints = false
        idForgetButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        idForgetButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        idForgetButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 85).isActive = true
        idForgetButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 560).isActive = true
        
        let passwordForgetButton = UIButton()
        passwordForgetButton.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        passwordForgetButton.setTitle("비밀번호 재설정", for: .normal)
        passwordForgetButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        passwordForgetButton.titleLabel?.font = UIFont(name: "NotoSans-Regular", size: 10)
        passwordForgetButton.titleLabel?.textAlignment = .center
        passwordForgetButton.contentHorizontalAlignment = .center
        passwordForgetButton.contentVerticalAlignment = .center
        passwordForgetButton.underLineText() // 버튼 텍스트에 밑줄을 추가하는 사용자 지정 확장 메서드 호출
        passwordForgetButton.addTarget(self, action: #selector(passwordResetting), for: .touchUpInside)

        self.view.addSubview(passwordForgetButton)
        passwordForgetButton.translatesAutoresizingMaskIntoConstraints = false
        passwordForgetButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        passwordForgetButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        passwordForgetButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -85).isActive = true
        passwordForgetButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 560).isActive = true

    }
    
    @objc func idFind() {
        guard  let idVC = storyboard?.instantiateViewController(withIdentifier: "idFind") as? IdFindViewController else { return }
        self.navigationController?.pushViewController(idVC, animated: true)
    }
    
    @objc func passwordResetting() {
        guard  let passwordVC = storyboard?.instantiateViewController(withIdentifier: "resettingPasswordInfo") as? ResettingPasswordInfoViewController else { return }
        self.navigationController?.pushViewController(passwordVC, animated: true)
    }
}

// 글씨 아래 밑줄
extension UIButton {
    func underLineText() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
