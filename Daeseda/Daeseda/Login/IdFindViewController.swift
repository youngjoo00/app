//
//  IdFindViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/16.
//

import UIKit
import Alamofire

struct User : Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
}

struct Address: Codable {
    var street: String
    var city: String
    var zipcode: String
}

class IdFindViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel()
        nextButton()

    }
    
    func titleLabel(){

        let title = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        title.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title.font = UIFont(name: "GmarketSans-Medium", size: 25)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        // Line height: 25 pt
        title.text = "이름과 휴대번호를 \n입력해주세요."

        self.view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.widthAnchor.constraint(equalToConstant: 300).isActive = true
        title.heightAnchor.constraint(equalToConstant: 50).isActive = true
        title.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 36).isActive = true
        title.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 123).isActive = true
        
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y: 0, width: 40, height: 41)
        nameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        nameLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        nameLabel.text = "이름"

        self.view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 41).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 250).isActive = true
        
        // Auto layout, variables, and unit scale are not yet supported
        let phone = UILabel()
        phone.frame = CGRect(x: 0, y: 0, width: 82, height: 38)
        phone.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        phone.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        phone.text = "휴대번호"

        self.view.addSubview(phone)
        phone.translatesAutoresizingMaskIntoConstraints = false
        phone.widthAnchor.constraint(equalToConstant: 82).isActive = true
        phone.heightAnchor.constraint(equalToConstant: 38).isActive = true
        phone.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 45).isActive = true
        phone.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 360).isActive = true
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
        
//        nextButton.addTarget(self, action: #selector(showRequestInfoViewController), for: .touchUpInside)
        
        
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
//    @objc func showRequestInfoViewController() {
//        guard  let requestInfoVC = storyboard?.instantiateViewController(withIdentifier: "requestInfo") as? RequestInfoViewController else { return }
//        self.navigationController?.pushViewController(requestInfoVC, animated: true)
//    }

}
