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
        
    }
    
    
    @IBAction func postBut(_ sender: Any) {
        join()
    }
    
    func join() {
        //        guard let name = nameTextField.text else { return }
        
        let otherParameters: [String: Any] = [
            "userEmail": "use234@example.com",
            "userName": "JohneA",
            "userNickname": "johndoe00",
            "userPhone": "123-456-1234",
            "userPassword": "securepassword"
        ]
        
        
        Request.shared.requestPost(url: "http://localhost:8088/users/signup", param: otherParameters) { response in
            
            switch response {
            case .success(let data):
                guard let data = data as? Response else { return }
                print(data)
                print("통신은 됨")
            case .requestErr(let err):
                print(err)
            case .pathErr:
                print("pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        }
    }
    
    @IBAction func dataGet(_ sender: Any) {
        getData()
    }
    
    
    func getData() {
        Request.shared.requestGet(url: APICollection.loginURL) { success, response in
            if success {
                if let data = response as? [String: Any] {
                    print(data)
                }
            } else {
                print("요청 실패")
            }
        }
    }
    
}
