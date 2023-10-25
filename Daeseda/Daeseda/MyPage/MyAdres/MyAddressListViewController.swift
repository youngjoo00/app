import UIKit
import Alamofire

class MyAddressListViewController: UIViewController {

    let url = "http://localhost:8888/users/address/list"

    var addressArr = [Address]()

    @IBOutlet weak var myAdressListTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        myAdressListTableView.delegate = self
        myAdressListTableView.dataSource = self
        
        getAddressListData()
    }
    
    func getAddressListData() {
        if let token = UserTokenManager.shared.getToken() {
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]

            AF.request(url, headers: headers).responseDecodable(of: [Address].self) { response in
                switch response.result {
                case .success(let addressData):
                    // 요청이 성공한 경우
                    self.addressArr = addressData
                    self.myAdressListTableView.reloadData() // 테이블 뷰를 업데이트
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getAddressListData()
        // 탭 바를 숨깁니다.
        tabBarController?.tabBar.isHidden = true
    }
}

extension MyAddressListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension MyAddressListViewController: UITableViewDataSource {
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
