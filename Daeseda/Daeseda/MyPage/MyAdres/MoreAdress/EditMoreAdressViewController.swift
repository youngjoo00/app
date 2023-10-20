import UIKit

class EditMoreAdressViewController: UIViewController {
    
    var indexPath: IndexPath?
    var address: String?
    var isEditHomeButtonSelected = false
    var isEditOtherButtonSelected = false
    
    var titleText: String?
    var adressText: String?
    var nickname: String?
    
    @IBOutlet weak var editMoreAdressNicknameTF: UITextField!
    @IBOutlet weak var editMoreAdressTF: UITextField!
    @IBOutlet weak var editMoreAdressLabel: UILabel!
    @IBOutlet weak var editMoreAdressTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        editMoreAdressTitle.text = titleText
        editMoreAdressLabel.text = adressText
        editMoreAdressTF.text = adressText
        editMoreAdressNicknameTF.text = nickname
        
        editMoreAdressNicknameTF.delegate = self
        editMoreAdressTF.delegate = self
        
        // 배경을 터치했을 때 키보드 내리기 위한 UITapGestureRecognizer 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        view.addGestureRecognizer(tapGesture)

        
    }
    
    @IBAction func editMoreAdressComplete(_ sender: UIButton) {

        print(editMoreAdressTF.text!)
        print(editMoreAdressNicknameTF.text!)
        // 이전 화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }


    
    @objc func handleBackgroundTap() {
        editMoreAdressNicknameTF.resignFirstResponder()
        editMoreAdressTF.resignFirstResponder()
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

extension EditMoreAdressViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
