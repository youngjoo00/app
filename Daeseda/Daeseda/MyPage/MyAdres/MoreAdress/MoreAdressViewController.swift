import UIKit

class MoreAdressViewController: UIViewController {
    
    var indexPath: IndexPath?
    var address: String?
    var isHome: Bool?
    var isHomeButtonSelected = false
    var isOtherButtonSelected = false
    
    @IBOutlet weak var moreAdressStackView: UIStackView!
    @IBOutlet weak var moreAdressOtherBtn: UIButton!
    @IBOutlet weak var moreAdressHomeBtn: UIButton!
    @IBOutlet weak var moreAdressNicknameTF: UITextField!
    @IBOutlet weak var moreAdressTF: UITextField!
    @IBOutlet weak var moreAdressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moreAdressNicknameTF.delegate = self
        moreAdressTF.delegate = self
        
        if let adress = address {
            moreAdressLabel.text = adress
        }
        
        // 배경을 터치했을 때 키보드 내리기 위한 UITapGestureRecognizer 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        view.addGestureRecognizer(tapGesture)
        
        removeBorderFromButton(moreAdressHomeBtn)
        removeBorderFromButton(moreAdressOtherBtn)

    }
    
    
    @IBAction func MoreAdressHomeBtn(_ sender: UIButton) {
        if isHomeButtonSelected {
            return
        }
        
        isHomeButtonSelected = true
        isOtherButtonSelected = false
        isHome = true
        addBorderToButton(moreAdressHomeBtn)
        removeBorderFromButton(moreAdressOtherBtn)
        
        moreAdressNicknameTF.isHidden = true
    }

    @IBAction func MoreAdressOtherBtn(_ sender: UIButton) {
        if isOtherButtonSelected {
            return
        }
        
        isHomeButtonSelected = false
        isOtherButtonSelected = true
        isHome = false
        addBorderToButton(moreAdressOtherBtn)
        removeBorderFromButton(moreAdressHomeBtn)
        
        moreAdressNicknameTF.isHidden = false
    }

    
    @IBAction func moreAdressCompleteBtn(_ sender: UIButton) {
        if let nickname = moreAdressNicknameTF.text {
            print("주소 별명: \(nickname)")
        }
        
        if let detailAddress = moreAdressTF.text {
            print("세부 주소: \(detailAddress)")
        }

        if let labelText = moreAdressLabel.text {
            print("레이블 텍스트: \(labelText)")
        }
        
        if let isHomeBtn = isHome {
            print("우리 집? : \(isHomeBtn)")
        }
        
        // MyAdressVC로 이동
        if let navigationController = self.navigationController {
            for viewController in navigationController.viewControllers {
                if let myAdressVC = viewController as? MyAdressViewController {
                    navigationController.popToViewController(myAdressVC, animated: true)
                    break
                }
            }
        }
    }

    
    @objc func handleBackgroundTap() {
        moreAdressNicknameTF.resignFirstResponder()
        moreAdressTF.resignFirstResponder()
    }
    
    func addBorderToButton(_ button: UIButton) {
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor(red: 0.36, green: 0.55, blue: 0.95, alpha: 1.0).cgColor
        button.layer.cornerRadius = 5.0
    }

    func removeBorderFromButton(_ button: UIButton) {
        button.layer.borderWidth = 1.0 // 보더의 두께를 조절할 수 있습니다.
        button.layer.borderColor = UIColor.lightGray.cgColor // 보더의 색상을 설정할 수 있습니다.
        button.layer.cornerRadius = 5.0 // 버튼의 모서리를 둥글게 만듭니다.
    }
}

extension MoreAdressViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
}
