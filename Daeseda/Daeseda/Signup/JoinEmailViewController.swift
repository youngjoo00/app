//
//  JoinEmailViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/17.
//

import UIKit

class JoinEmailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label()
        nextButton()

    }
    func label(){
        let email = UILabel()
        email.frame = CGRect(x: 0, y: 0, width: 98.51, height: 41.11)
        email.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        email.font = UIFont(name: "Inter-Regular", size: 20)
        // Line height: 24.2 pt
        email.text = "이메일"

        self.view.addSubview(email)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.widthAnchor.constraint(equalToConstant: 98.51).isActive = true
        email.heightAnchor.constraint(equalToConstant: 41.11).isActive = true
        email.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        email.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        
        // Auto layout, variables, and unit scale are not yet supported
        let check = UILabel()
        check.frame = CGRect(x: 0, y: 0, width: 82.22, height: 42.66)
        check.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        check.font = UIFont(name: "Inter-Regular", size: 20)
        // Line height: 24.2 pt
        check.text = "인증번호"

        self.view.addSubview(check)
        check.translatesAutoresizingMaskIntoConstraints = false
        check.widthAnchor.constraint(equalToConstant: 82.22).isActive = true
        check.heightAnchor.constraint(equalToConstant: 42.66).isActive = true
        check.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        check.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 230).isActive = true
    }
    
    func checkButton(){
        let checkButton = UIButton()
        checkButton.frame = CGRect(x: 0, y: 0, width: 100, height: 20)
        checkButton.setTitle("인증", for: .normal) // 버튼 텍스트 설정
        checkButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        checkButton.titleLabel?.font = UIFont(name: "NotoSans-Regular", size: 10)
        checkButton.addTarget(self, action: #selector(checkEmail), for: .touchUpInside)

        self.view.addSubview(checkButton)
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        checkButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        checkButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 235).isActive = true
        checkButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 474).isActive = true
    }
    
    @objc func checkEmail() {
        guard  let joinAgreeVC = storyboard?.instantiateViewController(withIdentifier: "joinAgree") as? JoinAgreeViewController else { return }
        self.navigationController?.pushViewController(joinAgreeVC, animated: true)
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
        nextButton.addTarget(self, action: #selector(joinInfo1VC), for: .touchUpInside)
        
        
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
    @objc func joinInfo1VC() {
        guard  let joinInfo1VC = storyboard?.instantiateViewController(withIdentifier: "joinInfo1") as? JoinInfo1ViewController else { return }
        self.navigationController?.pushViewController(joinInfo1VC, animated: true)
    }
}
