//
//  ResettingPasswordViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/17.
//

import UIKit

class ResettingPasswordViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label()
        
    }
    
    func label() {
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        title.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title.font = UIFont(name: "GmarketSansTTFMedium", size: 20)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        // Line height: 25 pt
        title.text = "재설정할 비밀번호를\n입력해주세요."

        self.view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        title.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120).isActive = true
        
        let password = UILabel()
        password.frame = CGRect(x: 0, y: 0, width: 98.51, height: 41.11)
        password.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        password.font = UIFont(name: "NotoSansKR-Regular", size: 17)
        // Line height: 24.2 pt
        password.text = "비밀번호"

        self.view.addSubview(password)
        password.translatesAutoresizingMaskIntoConstraints = false
        password.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        password.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 200).isActive = true
        
        // Auto layout, variables, and unit scale are not yet supported
        let check = UILabel()
        check.frame = CGRect(x: 0, y: 0, width: 82.22, height: 42.66)
        check.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        check.font = UIFont(name: "NotoSansKR-Regular", size: 17)
        // Line height: 24.2 pt
        check.text = "비밀번호 확인"

        self.view.addSubview(check)
        check.translatesAutoresizingMaskIntoConstraints = false
        check.widthAnchor.constraint(equalToConstant: 82.22).isActive = true
        check.heightAnchor.constraint(equalToConstant: 42).isActive = true
        check.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        check.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 310).isActive = true
    }
    
}
