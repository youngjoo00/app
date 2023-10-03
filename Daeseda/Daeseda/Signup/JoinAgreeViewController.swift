//
//  JoinAgreeViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/17.
//

import UIKit

class JoinAgreeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton()
        self.navigationItem.title = "회원가입"

    }
   
    func nextButton(){
        let nextButton = UIBarButtonItem(title: "다음", style: .plain, target: self, action: #selector(JoinEmailVC))
            navigationItem.rightBarButtonItem = nextButton
    }
    @objc func JoinEmailVC() {
        guard  let joinEmailVC = storyboard?.instantiateViewController(withIdentifier: "joinEmail") as? JoinEmailViewController else { return }
        self.navigationController?.pushViewController(joinEmailVC, animated: true)
    }
    
}
