import UIKit
import Alamofire

class MyAdressViewController: UIViewController {

    let endPoint = "/users/address/list"
    var selectedIndexPath: IndexPath?
    var addressArr = [Address]()

    @IBOutlet weak var myAdresSearchBar: UISearchBar!
    @IBOutlet weak var myAdressTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.myAdresSearchBar.searchBarStyle = .minimal

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationItem.title = "주소 목록"
        if let navigationBar = self.navigationController?.navigationBar {
            let font = WDFont.GmarketBold.of(size: 30)
            navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        getAddressesData()
        // 탭 바를 숨깁니다.
        tabBarController?.tabBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 다른 화면으로 이동할 때 탭 바를 다시 보이게 합니다.
        tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = .none

    }
    
    @objc func handleAddressDataUpdated(_ notification: Notification) {
        getAddressesData()
        myAdressTableView.reloadData()
    }

    func getAddressesData() {
        let fullURL = baseURL.baseURLString + self.endPoint
        
        if let token = UserTokenManager.shared.getToken() {
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]

            AF.request(fullURL, headers: headers).responseDecodable(of: [Address].self) { response in
                switch response.result {
                case .success(let addressData):
                    // 요청이 성공한 경우
                    self.addressArr = addressData
                    self.myAdressTableView.reloadData() // 테이블 뷰를 업데이트
                case .failure(let error):
                    // 요청이 실패한 경우
                    if let data = response.data {
                        let errorMessage = String(data: data, encoding: .utf8)
                        print("에러: \(error.localizedDescription)")
                        print("에러 응답 데이터: \(errorMessage ?? "N/A")")
                    } else {
                        print("에러: \(error.localizedDescription)")
                    }
                }
            }
        } else {
            print("토큰을 사용할 수 없습니다.")
        }
    }

    func postAddressDefalut(selectedAddress: Address) {
        let addressDefalutUrl = baseURL.baseURLString + "/users/address/setting"

        let parameters = Address(addressId: selectedAddress.addressId, addressName: selectedAddress.addressName, addressRoad: selectedAddress.addressRoad, addressDetail: selectedAddress.addressDetail, addressZipcode: selectedAddress.addressZipcode, defaultAddress: selectedAddress.defaultAddress)


        if let token = UserTokenManager.shared.getToken() {
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]

            AF.request(addressDefalutUrl, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers)
                .response { response in
                    switch response.result {
                    case .success:
                        print("기본 주소로 설정되었습니다.")
                        self.getAddressesData() // 선택한 주소를 기본 주소로 설정한 후 업데이트 또는 다른 필요한 작업 수행
                    case .failure(let error):
                        print("기본 주소 설정 실패: \(error.localizedDescription)")
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
}

extension MyAdressViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1. 알림 창을 표시
        let alertController = UIAlertController(title: "", message: "기본 주소로 설정하시겠습니까?", preferredStyle: .alert)

        // 2. "확인" 버튼을 추가하고 클릭 시 주소를 기본 주소로 설정하는 동작을 추가
        let confirmAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let selectedAddress = self.addressArr[indexPath.row]
            self.postAddressDefalut(selectedAddress: selectedAddress)
        }
        alertController.addAction(confirmAction)

        // 3. "취소" 버튼 추가
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        // 4. 알림 창을 표시
        present(alertController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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
        
        if addressArr[indexPath.row].defaultAddress {
            myAdressCell.adressCheckImageView.isHidden = false
            myAdressCell.adressCheckImageView.image = checkImage
        } else {
            myAdressCell.adressCheckImageView.isHidden = true
        }
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
