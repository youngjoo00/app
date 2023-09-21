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

        label()
        nextButton()
    }
    
    func label(){
        let id = UILabel()
        id.frame = CGRect(x: 0, y: 0, width: 80, height: 41)
        id.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        id.font = UIFont(name: "Inter-Regular", size: 20)
        // Line height: 24.2 pt
        id.text = "아이디"

        self.view.addSubview(id)
        id.translatesAutoresizingMaskIntoConstraints = false
        id.widthAnchor.constraint(equalToConstant: 80).isActive = true
        id.heightAnchor.constraint(equalToConstant: 27).isActive = true
        id.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        id.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        
        let name = UILabel()
        name.frame = CGRect(x: 0, y: 0, width: 40, height: 41)
        name.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        name.font = UIFont(name: "Inter-Regular", size: 20)
        // Line height: 24.2 pt
        name.text = "이름"

        self.view.addSubview(name)
        name.translatesAutoresizingMaskIntoConstraints = false
        name.widthAnchor.constraint(equalToConstant: 40).isActive = true
        name.heightAnchor.constraint(equalToConstant: 27).isActive = true
        name.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        name.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 220).isActive = true
        
        let nickname = UILabel()
        nickname.frame = CGRect(x: 0, y: 0, width: 61.69, height: 42.29)
        nickname.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        nickname.font = UIFont(name: "Inter-Regular", size: 20)
        // Line height: 24.2 pt
        nickname.text = "닉네임"

        self.view.addSubview(nickname)
        nickname.translatesAutoresizingMaskIntoConstraints = false
        nickname.widthAnchor.constraint(equalToConstant: 61.69).isActive = true
        nickname.heightAnchor.constraint(equalToConstant: 27).isActive = true
        nickname.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        nickname.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 290).isActive = true
        
        let password = UILabel()
        password.frame = CGRect(x: 0, y: 0, width: 80, height: 41)
        password.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        password.font = UIFont(name: "Inter-Regular", size: 20)
        // Line height: 24.2 pt
        password.text = "비밀번호"

        self.view.addSubview(password)
        password.translatesAutoresizingMaskIntoConstraints = false
        password.widthAnchor.constraint(equalToConstant: 80).isActive = true
        password.heightAnchor.constraint(equalToConstant: 27).isActive = true
        password.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        password.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 360).isActive = true
        
        let checkPassword = UILabel()
        checkPassword.frame = CGRect(x: 0, y: 0, width: 131, height: 41)
        checkPassword.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        checkPassword.font = UIFont(name: "Inter-Regular", size: 20)
        // Line height: 24.2 pt
        checkPassword.text = "비밀번호 확인"

        self.view.addSubview(checkPassword)
        checkPassword.translatesAutoresizingMaskIntoConstraints = false
        checkPassword.widthAnchor.constraint(equalToConstant: 131).isActive = true
        checkPassword.heightAnchor.constraint(equalToConstant: 27).isActive = true
        checkPassword.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        checkPassword.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 430).isActive = true
    }
    
    func nextButton(){
        var nextButton = UIButton()
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
        self.navigationController?.pushViewController(joinInfo2VC, animated: true)
    }
    
    // + 중복확인 버튼
}
