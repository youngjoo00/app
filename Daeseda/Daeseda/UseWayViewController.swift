import UIKit

class UseWayViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "이용방법"
        
        applyButton()
        imageVeiw()
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: 1200)
        
    }
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    func imageVeiw(){
        let imageView = UIImageView(image: UIImage(named: "이용방법_사진"))
        scrollView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func applyButton(){
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
        nextButton.addTarget(self, action: #selector(requestVC), for: .touchUpInside)
        
        
        let naxtText = UILabel()
        naxtText.frame = CGRect(x: 0, y: 0, width: 37, height: 27)
        naxtText.textColor = UIColor.white
        naxtText.font = UIFont(name: "NotoSansKR-Black", size: 20)
        // Line height: 27.24 pt
        naxtText.textAlignment = .center
        naxtText.text = "세탁 신청하기"
        
        self.view.addSubview(naxtText)
        naxtText.translatesAutoresizingMaskIntoConstraints = false
        naxtText.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
        naxtText.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
    }
    @objc func requestVC() {
        guard  let requestVC = storyboard?.instantiateViewController(withIdentifier: "request") as? RequestViewController else { return }
        
        if var viewControllers = self.navigationController?.viewControllers{
            viewControllers.removeLast()
            viewControllers.append(requestVC)
            
            self.navigationController?.setViewControllers(viewControllers, animated: true)
        }
    }
}
