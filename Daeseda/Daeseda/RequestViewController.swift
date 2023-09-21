//
//  RequestViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/16.
//

import UIKit

class RequestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        nextButton()
        textLabel()

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
        nextButton.addTarget(self, action: #selector(requestInfoVC), for: .touchUpInside)
        
        
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
    @objc func requestInfoVC() {
        guard  let requestInfoVC = storyboard?.instantiateViewController(withIdentifier: "requestInfo") as? RequestInfoViewController else { return }
        self.navigationController?.pushViewController(requestInfoVC, animated: true)
    }
    
    func textLabel() {
        // Auto layout, variables, and unit scale are not yet supported
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 0, y: 0, width: 56, height: 27)
        dateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        dateLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        dateLabel.textAlignment = .center
        dateLabel.text = "수거일"

        self.view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.widthAnchor.constraint(equalToConstant: 56).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        
        // Auto layout, variables, and unit scale are not yet supported
        let timeLabel = UILabel()
        timeLabel.frame = CGRect(x: 0, y: 0, width: 37, height: 27)
        timeLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        timeLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        timeLabel.textAlignment = .center
        timeLabel.text = "시간"

        self.view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.widthAnchor.constraint(equalToConstant: 37).isActive = true
        timeLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 220).isActive = true
        
        // Auto layout, variables, and unit scale are not yet supported
        let typeLabel = UILabel()
        typeLabel.frame = CGRect(x: 0, y: 0, width: 74, height: 27)
        typeLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        typeLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        typeLabel.textAlignment = .center
        typeLabel.text = "세탁종류"

        self.view.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.widthAnchor.constraint(equalToConstant: 74).isActive = true
        typeLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        typeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        typeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 290).isActive = true
        
        // Auto layout, variables, and unit scale are not yet supported
        let categotyLabel = UILabel()
        categotyLabel.frame = CGRect(x: 0, y: 0, width: 74, height: 27)
        categotyLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        categotyLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        categotyLabel.textAlignment = .center
        categotyLabel.text = "카테고리"

        self.view.addSubview(categotyLabel)
        categotyLabel.translatesAutoresizingMaskIntoConstraints = false
        categotyLabel.widthAnchor.constraint(equalToConstant: 74).isActive = true
        categotyLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        categotyLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        categotyLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 360).isActive = true
    }
    
    func pickerView(){
        
    }
}
