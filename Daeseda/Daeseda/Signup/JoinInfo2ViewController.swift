//
//  JoinInfo2ViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/17.
//

import UIKit
import Alamofire

class JoinInfo2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "회원가입"
        
        label()
        endButton()
        
    }
    
    var userId : String = ""
    var userName : String = ""
    var userNicName : String = ""
    var userPassword : String = ""
    var userEmail : String = ""
    var userPhone : String = ""
    
//    let url = "http://localhost:8888/users/signup"
    let url = "http://42.201.98.204/users/signup"
    
    
    @IBOutlet weak var phoneStartTextField: UITextField!
    @IBOutlet weak var phoneFirstTextField: UITextField!
    @IBOutlet weak var phoneSecondTextField: UITextField!
    
    @IBOutlet weak var phoneErrorMessage: UILabel!
    
    
    @IBAction func phoneTextFieldEditingChanged(_ sender: Any) {
        if let phoneStart = phoneStartTextField.text ,let phoneFirst = phoneFirstTextField.text ,let phoneSecond = phoneSecondTextField.text{
            let pattern = "^01[0-1, 7][0-9]{7,8}$"
            let regex = try!NSRegularExpression(pattern: pattern)
            
            let phone = "\(phoneStart)\(phoneFirst)\(phoneSecond)"
            
            let match = regex.firstMatch(in: phone, range: NSRange(phone.startIndex..., in: phone))
            
            if match == nil {
                phoneErrorMessage.text = "휴대번호를 정확히 입력해주세요."
            } else {
                phoneErrorMessage.text = " "
                userPhone = "\(phoneStart)-\(phoneFirst)-\(phoneSecond)"
            }
        }
        
    }
    
    
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
        
        let phone = UILabel()
        phone.frame = CGRect(x: 0, y: 0, width: 82, height: 38)
        phone.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        phone.font = UIFont(name: "NotoSansKR-Regular", size: 18)
        // Line height: 24.2 pt
        phone.text = "휴대번호"
        
        self.view.addSubview(phone)
        phone.translatesAutoresizingMaskIntoConstraints = false
        phone.widthAnchor.constraint(equalToConstant: 82).isActive = true
        phone.heightAnchor.constraint(equalToConstant: 27).isActive = true
        phone.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        phone.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        
//        let check = UILabel()
//        check.frame = CGRect(x: 0, y: 0, width: 82.22, height: 42.66)
//        check.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
//        check.font = UIFont(name: "NotoSansKR-Regular", size: 18)
//        // Line height: 24.2 pt
//        check.text = "인증번호"
//        
//        self.view.addSubview(check)
//        check.translatesAutoresizingMaskIntoConstraints = false
//        check.widthAnchor.constraint(equalToConstant: 82.22).isActive = true
//        check.heightAnchor.constraint(equalToConstant: 27).isActive = true
//        check.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
//        check.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 310).isActive = true
//        
    }
    
    func endButton(){
        let nextButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(JoinEmailVC))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func JoinEmailVC() {
        // 알림 뜨고 확인 누르면 로그인 화면으로 이동할 액션
        let alert = UIAlertController(title:"축하합니다!",message: "가입이 완료되었습니다. \n다양한 서비스를 이용해보세요.",preferredStyle: UIAlertController.Style.alert)
        
        let userData = UserData(userEmail: userEmail, userName: userName, userNickname: userNicName, userPhone: userPhone, userPassword: userPassword)
        
        //확인 버튼 만들기
        let ok = UIAlertAction(title: "확인", style: .default, handler: { action in
            AF.request("\(baseURL.self)/users/signup", method: .post, parameters: userData, encoder: JSONParameterEncoder.default)
                .validate(statusCode: 200..<300)
                .response { response in
                    switch response.result {
                    case .success:
                        // 헤더 값 뽑아오기
                        if let responseHeaders = response.response?.allHeaderFields as? [String: String] {
                            for (key, value) in responseHeaders {
                                print("Header \(key): \(value)")
                            }
                        }
                        print("회원가입 성공")
                        
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }
            
            guard  let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "Login") as? LoginViewController else { return }
            
            if var viewControllers = self.navigationController?.viewControllers{
                viewControllers.removeAll(where: { $0 != self.navigationController?.viewControllers.first })
                viewControllers.append(loginVC)
                
                self.navigationController?.setViewControllers(viewControllers, animated: true)
            }
        })
        
        //확인 버튼 경고창에 추가하기
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
}
