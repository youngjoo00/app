//
//  RequestInfoViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/16.
//

import UIKit

class RequestInfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel()

    }
    func textLabel(){

        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y: 0, width: 37, height: 27)
        nameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        nameLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        nameLabel.textAlignment = .center
        nameLabel.text = "이름"

        self.view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.widthAnchor.constraint(equalToConstant: 37).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        nameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        
        let phoneLabel = UILabel()
        phoneLabel.frame = CGRect(x: 0, y: 0, width: 74, height: 27)
        phoneLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        phoneLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        phoneLabel.textAlignment = .center
        phoneLabel.text = "전화번호"

        self.view.addSubview(phoneLabel)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.widthAnchor.constraint(equalToConstant: 74).isActive = true
        phoneLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        phoneLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        phoneLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 220).isActive = true
        
        let addressLabel = UILabel()
        addressLabel.frame = CGRect(x: 0, y: 0, width: 131, height: 27)
        addressLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        addressLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        addressLabel.text = "수거/배송주소"

        self.view.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.widthAnchor.constraint(equalToConstant: 131).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        addressLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 290).isActive = true
        
        let searchView = UIView()
        searchView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        let searchImage = UIImage(systemName: "magnifyingglass")?.cgImage
        let layer1 = CALayer()
        layer1.contents = searchImage
        layer1.bounds = searchView.bounds
        layer1.position = searchView.center
        searchView.layer.addSublayer(layer1)

        self.view.addSubview(searchView)
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.widthAnchor.constraint(equalToConstant: 27).isActive = true
        searchView.heightAnchor.constraint(equalToConstant: 27).isActive = true
        searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        searchView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 330).isActive = true
        
        let positionLabel = UILabel()
        positionLabel.frame = CGRect(x: 0, y: 0, width: 74, height: 27)
        positionLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        positionLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        positionLabel.text = "위탁장소"

        self.view.addSubview(positionLabel)
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.widthAnchor.constraint(equalToConstant: 74).isActive = true
        positionLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        positionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        positionLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 420).isActive = true
    }

}
