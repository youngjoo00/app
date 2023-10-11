//
//  ResettingPasswordInfoViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/08.
//

import UIKit

class ResettingPasswordInfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label()
        nextButton()
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var typeTextField: UITextField!
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            typeLabel.text = "휴대전화"
            errorMessage.text = " "
            typeTextField.addTarget(self, action: #selector(textFieldDidChangeForSegmentA(_:)), for: .editingChanged)
            
        case 1:
            typeLabel.text = "이메일"
            errorMessage.text = " "
            typeTextField.addTarget(self, action: #selector(textFieldDidChangeForSegmentB(_:)), for: .editingChanged)
            
        default:
            break
        }
    }
    
    @objc func textFieldDidChangeForSegmentA(_ sender: UITextField) {
        if let phone = typeTextField.text{
            let pattern = "^01[0-1, 7][0-9]{7,8}$"
            let regex = try!NSRegularExpression(pattern: pattern)
            
            let match = regex.firstMatch(in: phone, range: NSRange(phone.startIndex..., in: phone))
            
            if match == nil {
                errorMessage.text = "휴대번호를 정확히 입력해주세요."
            } else {
                errorMessage.text = " "
                nextButton()
            }
        }
    }
    
    @objc func textFieldDidChangeForSegmentB(_ sender: UITextField) {
        if let email = typeTextField.text {
            let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let regex = try! NSRegularExpression(pattern: pattern)
            
            let match = regex.firstMatch(in: email, range: NSRange(email.startIndex..., in: email))
            
            if match == nil {
                errorMessage.text = "이메일을 정확히 입력해주세요."
            } else {
                errorMessage.text = " "
                nextButton()
            }
        }
        
    }
    
    func label() {
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        title.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title.font = UIFont(name: "GmarketSansTTFMedium", size: 20)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        // Line height: 25 pt
        title.text = "비밀번호를 잊으셨다면\n재설정할 수 있어요."
        
        self.view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        title.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120).isActive = true
    }
    
    func nextButton(){
        let nextButton = UIButton()
        nextButton.frame = CGRect(x: 0, y: 0, width: 250, height: 34)
        nextButton.layer.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1).cgColor
        nextButton.layer.cornerRadius = 10
        
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        nextButton.addTarget(self, action: #selector(resettingPasswordVC), for: .touchUpInside)
        
        
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
    
    @objc func resettingPasswordVC() {
        guard  let resettingPasswordVC = storyboard?.instantiateViewController(withIdentifier: "resettingPassword") as? ResettingPasswordViewController else { return }
        
        self.navigationController?.pushViewController(resettingPasswordVC, animated: true)
    }
}
