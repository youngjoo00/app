//
//  JoinInfo2ViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/17.
//

import UIKit

class JoinInfo2ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label()
        endButton()
    }
    
    func label(){
        let phone = UILabel()
        phone.frame = CGRect(x: 0, y: 0, width: 82, height: 38)
        phone.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        phone.font = UIFont(name: "Inter-Regular", size: 20)
        // Line height: 24.2 pt
        phone.text = "휴대번호"
        
        self.view.addSubview(phone)
        phone.translatesAutoresizingMaskIntoConstraints = false
        phone.widthAnchor.constraint(equalToConstant: 82).isActive = true
        phone.heightAnchor.constraint(equalToConstant: 27).isActive = true
        phone.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        phone.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        
        let check = UILabel()
        check.frame = CGRect(x: 0, y: 0, width: 82.22, height: 42.66)
        check.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        check.font = UIFont(name: "Inter-Regular", size: 20)
        // Line height: 24.2 pt
        check.text = "인증번호"
        
        self.view.addSubview(check)
        check.translatesAutoresizingMaskIntoConstraints = false
        check.widthAnchor.constraint(equalToConstant: 82.22).isActive = true
        check.heightAnchor.constraint(equalToConstant: 27).isActive = true
        check.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        check.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 220).isActive = true
        
        let address = UILabel()
        address.frame = CGRect(x: 0, y: 0, width: 39.08, height: 28)
        address.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        address.font = UIFont(name: "Inter-Regular", size: 20)
        // Line height: 24.2 pt
        address.text = "주소"
        
        self.view.addSubview(address)
        address.translatesAutoresizingMaskIntoConstraints = false
        address.widthAnchor.constraint(equalToConstant: 39.08).isActive = true
        address.heightAnchor.constraint(equalToConstant: 27).isActive = true
        address.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        address.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 290).isActive = true
        
        let detail = UILabel()
        detail.frame = CGRect(x: 0, y: 0, width: 74, height: 28)
        detail.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        detail.font = UIFont(name: "Inter-Regular", size: 20)
        // Line height: 24.2 pt
        detail.text = "상세주소"
        
        self.view.addSubview(detail)
        detail.translatesAutoresizingMaskIntoConstraints = false
        detail.widthAnchor.constraint(equalToConstant: 74).isActive = true
        detail.heightAnchor.constraint(equalToConstant: 27).isActive = true
        detail.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        detail.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 390).isActive = true
    }
    
    func endButton(){
        let nextButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(JoinEmailVC))
        navigationItem.rightBarButtonItem = nextButton
    }
    @objc func JoinEmailVC() {
        // 알림 뜨고 확인 누르면 로그인 화면으로 이동할 액션
        let alert = UIAlertController(title:"축하합니다!",message: "가입이 완료되었습니다. \n다양한 서비스를 이용해보세요.",preferredStyle: UIAlertController.Style.alert)
        //확인 버튼 만들기
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
//        let ok = UIAlertAction(title: "확인", style: .default, handler: { action in
//            diaryList.selectedEggId = self.saveId
//            newDiary.save() // 내용 저장
//
//            if var viewControllers = self.navigationController?.viewControllers {
//                viewControllers.removeLast()
//                viewControllers.append(diaryList)
//                self.navigationController?.setViewControllers(viewControllers, animated: true)
//            }
//
//        })
        
        //확인 버튼 경고창에 추가하기
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
}
