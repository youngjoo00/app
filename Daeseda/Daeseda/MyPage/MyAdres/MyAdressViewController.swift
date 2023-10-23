import UIKit
import Alamofire

class MyAdressViewController: UIViewController {
    
    let url = "http://localhost:8888/users/address/list"
    var selectedIndexPath: IndexPath?
    var addressArr = [Address]()
    
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
        
        let addressEditBarBtn = UIBarButtonItem(
            title: "편집",
            style: .plain,
            target: self,
            action: #selector(addressEditBarBtnTab)
        )
        
        navigationItem.rightBarButtonItem = addressEditBarBtn
        
        selectedIndexPath = IndexPath(row: 0, section: 0)
        
        myAdressTableView.delegate = self
        myAdressTableView.dataSource = self
        myAdresSearchBar.delegate = self
        
        getAddressesData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleAddressDataUpdated(_:)), name: NSNotification.Name("AddressDataUpdated"), object: nil)
    }
    

    @objc func handleAddressDataUpdated(_ notification: Notification) {
        getAddressesData()
        myAdressTableView.reloadData()
    }
    
    func getAddressesData() {
        if let token = UserTokenManager.shared.getToken() {
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            AF.request(url, headers: headers).responseDecodable(of: [Address].self) { response in
                switch response.result {
                case .success(let addressData):
                    let addresses = addressData.map { address in
                        var modifiedAddress = address
                        if address.addressRoad == nil {
                            modifiedAddress.addressRoad = ""
                        }
                        return modifiedAddress
                    }
                    // 요청이 성공한 경우
                    self.addressArr = addresses
                    self.myAdressTableView.reloadData() // 테이블 뷰를 업데이트
                case .failure(let error):
                    // 요청이 실패한 경우
                    if let data = response.data {
                        let errorMessage = String(data: data, encoding: .utf8)
                        print("Error: \(error.localizedDescription)")
                        print("Error Response Data: \(errorMessage ?? "N/A")")
                    } else {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            print("Token not available.")
        }
    }
    
    @objc func addressEditBarBtnTab(_ sender: UIBarButtonItem) {
        guard let addressEditVC = storyboard?.instantiateViewController(withIdentifier: "AdressEdit") as? AdressEditViewController else { return }
        navigationController?.pushViewController(addressEditVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getAddressesData()
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
        
        var postAdderssData = addressArr[indexPath.row]
        
        NotificationCenter.default.post(name:NSNotification.Name("postAddressNotification"), object: postAdderssData)
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
        return addressArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myAdressCell = tableView.dequeueReusableCell(withIdentifier: "myAdressCell", for: indexPath) as! MyAdressTableViewCell
        
        // 서버에서 받은 주소 데이터를 사용
        myAdressCell.adressTitleLabel.text = addressArr[indexPath.row].addressName
        myAdressCell.adressAdressLabel.text = addressArr[indexPath.row].addressDetail
        
        let adressImage = UIImage(systemName: "mappin.and.ellipse")
        let checkImage = UIImage(systemName: "checkmark.circle.fill")
        
        myAdressCell.adressImageView.image = adressImage
        myAdressCell.adressCheckImageView.isHidden = selectedIndexPath != indexPath
        myAdressCell.adressCheckImageView.image = checkImage
        
        return myAdressCell
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
