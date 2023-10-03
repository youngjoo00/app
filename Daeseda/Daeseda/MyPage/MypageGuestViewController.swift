//
//  mypageViewController.swift
//  Daeseda
//
//  Created by youngjoo on 2023/09/17.
//

import Foundation
import UIKit

class MyPageGuestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.Guest()
    }
        
    func Guest() {
        let contentView = UIView()
        contentView.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
        contentView.layer.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        self.view.addSubview(contentView)
        
        let loginLabel = UILabel()
        loginLabel.frame = CGRect(x: 31, y: 76, width: 115, height: 34)
        loginLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        loginLabel.font = UIFont(name: "NotoSans-bold", size: 25)
        loginLabel.text = "로그인하기"
        contentView.addSubview(loginLabel)
        
        let arrowLabel = UILabel()
        arrowLabel.frame = CGRect(x: 158, y: 82, width: 12, height: 27)
        arrowLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        arrowLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        arrowLabel.textAlignment = .center
        arrowLabel.text = ">"
        contentView.addSubview(arrowLabel)
        
        let descriptionLabel = UILabel()
        descriptionLabel.frame = CGRect(x: 31, y: 134, width: 237, height: 54)
        descriptionLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        descriptionLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        descriptionLabel.text = "대세다 회원만의\n편리한 세탁을 이용해보세요."
        contentView.addSubview(descriptionLabel)
        
        let customerServiceLabel = UILabel()
        customerServiceLabel.frame = CGRect(x: 31, y: 254, width: 74, height: 27)
        customerServiceLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        customerServiceLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        customerServiceLabel.text = "고객센터"
        contentView.addSubview(customerServiceLabel)
        
        let arrowLabel2 = UILabel()
        arrowLabel2.frame = CGRect(x: 352, y: 254, width: 12, height: 27)
        arrowLabel2.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        arrowLabel2.font = UIFont(name: "NotoSans-Regular", size: 20)
        arrowLabel2.textAlignment = .center
        arrowLabel2.text = ">"
        contentView.addSubview(arrowLabel2)
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 339, height: 0)
        let stroke = UIView()
        stroke.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.center = view.center
        view.addSubview(stroke)
        view.bounds = view.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke.layer.borderWidth = 1
        stroke.layer.borderColor = UIColor(red: 0.91, green: 0.91, blue: 0.929, alpha: 1).cgColor
        
        let parent = self.view!
        parent.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 339).isActive = true
        view.heightAnchor.constraint(equalToConstant: 0).isActive = true
        view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 25).isActive = true
        view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 296).isActive = true
        
        let settingsLabel = UILabel()
        settingsLabel.frame = CGRect(x: 31, y: 314, width: 37, height: 27)
        settingsLabel.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        settingsLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        settingsLabel.text = "설정"
        contentView.addSubview(settingsLabel)
        
        let arrowLabel3 = UILabel()
        arrowLabel3.frame = CGRect(x: 352, y: 314, width: 12, height: 27)
        arrowLabel3.textColor = UIColor(red: 0.067, green: 0.067, blue: 0.067, alpha: 1)
        arrowLabel3.font = UIFont(name: "NotoSans-Regular", size: 20)
        arrowLabel3.textAlignment = .center
        arrowLabel3.text = ">"
        contentView.addSubview(arrowLabel3)
    }
        
        

}
