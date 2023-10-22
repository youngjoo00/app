import UIKit
import Alamofire

class PriceListViewController: UIViewController {
    
    let categoryUrl = "http://localhost:8888/category/list"
    let clothesUrl = "http://localhost:8888/clothes/list"
    
    var categoryNames: [String] = []
    var clothesNames: [String] = []
    var clothesPrice: [String] = []
    
    @IBOutlet weak var generalButton: UIButton!
    @IBOutlet weak var specialButton: UIButton!
    var typeButtonArray = [UIButton]()
    
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    var categoryButtonArray = [UIButton]()
    
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        applyButton()
        
        typeButtonArray.append(generalButton)
        typeButtonArray.append(specialButton)
        
        categoryButtonArray.append(topButton)
        categoryButtonArray.append(bottomButton)
        
        line1.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1)
        fetchClothesInfo(categoryId: 1)
        topButton.tintColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1)

        
        listTableView.dataSource = self
        listTableView.delegate = self
        
    }
    
    func fetchClothesInfo(categoryId: Int) {
        AF.request("http://localhost:8888/clothes/list").responseDecodable(of: [GetClothes].self) { response in
            switch response.result {
            case .success(let clothes):
                // categoryId가 1인 옷만 필터링
                let filteredClothes = clothes.filter { $0.categoryId == categoryId }
                
                for cloth in filteredClothes {
                    self.clothesNames.append(cloth.clothesName)
                    self.clothesPrice.append(cloth.clothesPrice)
                }
                print("Clothes Names: \(filteredClothes)")
                print(self.clothesNames)
                print(self.clothesPrice)
                self.listTableView.reloadData()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    
    @IBAction func selectTypeBtnAction(_ sender: UIButton) {
        for Btn in typeButtonArray {
            if Btn == sender {
                switch sender {
                case generalButton : print("일반세탁")
                    line1.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1)
                    line2.backgroundColor = .clear
                case specialButton : print("특수세탁")
                    line2.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1)
                    line1.backgroundColor = .clear
                default : break
                }
            }
        }
    }
    
    @IBAction func selectCategoryButton(_ sender: UIButton) {
        for Btn in categoryButtonArray {
            if Btn == sender {
                Btn.isSelected = true
                Btn.tintColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1)
                clothesNames.removeAll() // 배열 초기화
                clothesPrice.removeAll()
                switch sender {
                case topButton : print("상의")
                    fetchClothesInfo(categoryId: 1)
                case bottomButton :  print("하의")
                    fetchClothesInfo(categoryId: 2)
                default : break
                }
            } else {
                Btn.isSelected = false
                Btn.tintColor = UIColor.black
            }
        }
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
        naxtText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
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
        self.navigationController?.pushViewController(requestVC, animated: true)
    }
    
}

extension PriceListViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clothesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pirceListTableViewCell", for: indexPath) as! PirceListTableViewCell
        
        cell.nameLabel.text = clothesNames[indexPath.row]
        cell.pirceLabel.text = clothesPrice[indexPath.row]
        
        return cell
    }
    
    
}
