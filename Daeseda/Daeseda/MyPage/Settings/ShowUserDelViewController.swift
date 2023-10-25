import UIKit
import Alamofire

class ShowUserDelViewController: UIViewController {
    
    var mainTabBarController: MainTabBarViewController!
    
    var userCheckDelBtn: Bool = false {
        didSet {
            // userCheckDelBtn 값이 변경될 때마다 버튼의 이미지와 색상을 업데이트합니다.
            let imageName = userCheckDelBtn ? "checkmark.circle.fill" : "checkmark.circle"
            let tintColor = userCheckDelBtn ? UIColor(hex: 0x5D8DF2) : UIColor.lightGray
            
            userDelCheckBtn.setImage(UIImage(systemName: imageName), for: .normal)
            userDelCheckBtn.tintColor = tintColor
            
            // userCheckDelBtn 값에 따라 lastUserDelBtn 버튼의 활성화/비활성화 상태를 변경합니다.
            lastUserDelBtn.isEnabled = userCheckDelBtn
            lastUserDelBtn.tintColor = userCheckDelBtn ? UIColor(hex: 0x5D8DF2) : UIColor.lightGray
        }
    }
    
    @IBOutlet weak var lastUserDelBtn: UIButton!
    @IBOutlet weak var userDelCheckBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userCheckDelBtn = false
    }
    
    @IBAction func closeBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func lastUserDelBtn(_ sender: UIButton) {
        // ...
    }
    
    @IBAction func userDelCheckBtn(_ sender: UIButton) {
        userCheckDelBtn.toggle()
    }

}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
