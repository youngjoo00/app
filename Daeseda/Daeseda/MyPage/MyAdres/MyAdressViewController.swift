import UIKit
import Alamofire

struct AddressData: Codable {
    var addressList: [Address]
    
    struct Address: Codable {
        var addressId: Int
        var addressName: String
        var addressDetail: String
        var addressZipcode: String
    }
}


class MyAdressViewController: UIViewController {
    
    let url = "http://localhost:8888/users/address/list"
    var selectedIndexPath: IndexPath?
    var adressArr = [AddressData.Address]()
    let homeTitle = "우리 집"
    let homeAdress = "서울시 노원구 초안산로 12"
    
    @IBOutlet weak var myAdresSearchBar: UISearchBar!
    @IBOutlet weak var myAdressTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.myAdresSearchBar.searchBarStyle = .minimal
        self.title = "주소 설정"
        
        if let navigationBar = self.navigationController?.navigationBar {
            let font = WDFont.GmarketBold.of(size: 30)
            navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        
        let adressEditBarBtn = UIBarButtonItem(
            title: "편집",
            style: .plain,
            target: self,
            action: #selector(adressEditBarBtnTab)
        )
        
        
        navigationItem.rightBarButtonItem = adressEditBarBtn
        
        selectedIndexPath = IndexPath(row: 0, section: 0)
        
        myAdressTableView.delegate = self
        myAdressTableView.dataSource = self
        myAdresSearchBar.delegate = self
        
        getAdressData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleAddressDataUpdated(_:)), name: NSNotification.Name("AddressDataUpdated"), object: nil)
    }
    
    @objc func handleAddressDataUpdated(_ notification: Notification) {
        getAdressData()
        myAdressTableView.reloadData()
    }
    
    func getAdressData() {
        if let token = UserTokenManager.shared.getToken() {
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            AF.request(url, headers: headers).responseDecodable(of: [AddressData].self) { response in
                switch response.result {
                case .success(let addressData):
                    // 요청이 성공한 경우
                    self.adressArr = addressData.first?.addressList ?? []
                    self.myAdressTableView.reloadData() // 테이블 뷰를 업데이트
                case .failure(let error):
                    // 요청이 실패한 경우
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Token not available.")
        }
    }
    
    
    @objc func adressEditBarBtnTab(_ sender: UIBarButtonItem) {
        guard let adressEditVC = storyboard?.instantiateViewController(withIdentifier: "AdressEdit") as? AdressEditViewController else { return }
        navigationController?.pushViewController(adressEditVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 탭 바를 숨깁니다.
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 다른 화면으로 이동할 때 탭 바를 다시 보이게 합니다.
        tabBarController?.tabBar.isHidden = false
    }
    
}

extension MyAdressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == selectedIndexPath {
        } else {
            selectedIndexPath = indexPath
        }
        myAdressTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MyAdressViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 주소 데이터의 개수 + 1(우리 집)을 반환
        return adressArr.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // 우리 집 주소를 표시
            let myHomeCell = tableView.dequeueReusableCell(withIdentifier: "myHomeCell", for: indexPath) as! MyHomeTableViewCell
            
            myHomeCell.homeTitleLabel.text = homeTitle // 고정값 대신에 "우리 집" 표시
            myHomeCell.homeAdressLabel.text = homeAdress // 우리 집의 주소는 서버에서 받은 데이터로 표시
            
            let houseImage = UIImage(systemName: "house")
            let checkImage = UIImage(systemName: "checkmark.circle.fill")
            
            myHomeCell.homeImageView.image = houseImage
            myHomeCell.homeCheckImageView.isHidden = selectedIndexPath != indexPath
            myHomeCell.homeCheckImageView.image = checkImage
            
            return myHomeCell
        } else {
            // 다른 주소들을 표시
            let myAdressCell = tableView.dequeueReusableCell(withIdentifier: "myAdressCell", for: indexPath) as! MyAdressTableViewCell
            
            // 섹션을 2개 사용해서 home값을 제외한 인덱스를 새로 정의
            let otherAdressIndex = indexPath.row - 1
            
            // 서버에서 받은 주소 데이터를 사용
            myAdressCell.adressTitleLabel.text = adressArr[otherAdressIndex].addressName
            myAdressCell.adressAdressLabel.text = adressArr[otherAdressIndex].addressDetail
            
            let adressImage = UIImage(systemName: "mappin.and.ellipse")
            let checkImage = UIImage(systemName: "checkmark.circle.fill")
            
            myAdressCell.adressImageView.image = adressImage
            myAdressCell.adressCheckImageView.isHidden = selectedIndexPath != indexPath
            myAdressCell.adressCheckImageView.image = checkImage
            
            return myAdressCell
        }
    }
}


extension MyAdressViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // 서치바를 터치하면 AddressSearchVC로 화면 전환
        if let addressSearchVC = storyboard?.instantiateViewController(withIdentifier: "AddressSearchVC") as? AddressSearchViewController {
            navigationController?.pushViewController(addressSearchVC, animated: true)
        }
        return false // false를 반환하여 서치바가 편집 모드로 들어가지 않도록 합니다.
    }
}
