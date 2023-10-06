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

    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorMessage: UILabel!
    
    var postId: String = ""
    
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
        
        let email = UILabel()
        email.frame = CGRect(x: 0, y: 0, width: 98.51, height: 41.11)
        email.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        email.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        // Line height: 24.2 pt
        email.text = "이메일"

        self.view.addSubview(email)
        email.translatesAutoresizingMaskIntoConstraints = false
        email.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        email.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        
        // Auto layout, variables, and unit scale are not yet supported
        let check = UILabel()
        check.frame = CGRect(x: 0, y: 0, width: 82.22, height: 42.66)
        check.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        check.font = UIFont(name: "NotoSansKR-Regular", size: 20)
        // Line height: 24.2 pt
        check.text = "인증번호"

        self.view.addSubview(check)
        check.translatesAutoresizingMaskIntoConstraints = false
        check.widthAnchor.constraint(equalToConstant: 82.22).isActive = true
        check.heightAnchor.constraint(equalToConstant: 42).isActive = true
        check.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        check.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 310).isActive = true
        
    }

    // 입력에 따라 이메일 형식 확인
    @IBAction func emailTextFieldEditingChanged(_ sender: Any) {
        
        if let email = emailTextField.text {
            let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let regex = try! NSRegularExpression(pattern: pattern)
            
            let match = regex.firstMatch(in: email, range: NSRange(email.startIndex..., in: email))
            
            if match == nil {
                emailErrorMessage.text = "이메일을 정확히 입력해주세요."
            } else {
                emailErrorMessage.text = " "
                nextButton()
            }
        }
    }
    
    // 입력이 끝난 후 중복 이메일 확인하는 코드 구현
//    @IBAction func emailTextFieldDidEndOnExit(_ sender: UITextField) {
//
//    }

    
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
//        guard  let joinInfo1VC = storyboard?.instantiateViewController(withIdentifier: "joinInfo1") as? JoinInfo1ViewController else { return }
//        joinInfo1VC.postId = self.emailTextField.text!
//        self.navigationController?.pushViewController(joinInfo1VC, animated: true)
    }
    
}
