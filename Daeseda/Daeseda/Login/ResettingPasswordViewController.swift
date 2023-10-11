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
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var password2TextField: UITextField!
    
    @IBOutlet weak var passwordErrorMessage: UILabel!
    @IBOutlet weak var password2ErrorMessage: UILabel!
    
    
    @IBAction func passwordTextFieldEditingChanged(_ sender: Any) {
        let errorMessage = passwordMatch(passwordTextField.text!)
        
        passwordErrorMessage.text = errorMessage

    }
    
    @IBAction func password2TextFieldDidEndOnExit(_ sender: Any) {
        if password2TextField.text != passwordTextField.text {
            password2ErrorMessage.text = "설정한 비밀번호와 일치하지 않습니다."
        } else {
            password2ErrorMessage.text = " "
            endButton()
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
    
    func endButton(){
        let nextButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(EndVC))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func EndVC() {
        
        guard let endVC = storyboard?.instantiateViewController(withIdentifier: "ResettingPasswordEnd") as? ResettingPasswordEndViewController else { return }
        
        self.navigationController?.pushViewController(endVC, animated: true)
    }
    
}
