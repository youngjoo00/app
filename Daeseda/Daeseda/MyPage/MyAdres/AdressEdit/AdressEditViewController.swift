import UIKit
import Alamofire

class AdressEditViewController: UIViewController {
    
    let url = "http://localhost:8888/users/address/list"
    var selectedIndexPath: IndexPath?
    var addressData = [AddressData.Address]()
    var homeTitle = "우리 집"
    var homeAddress = "서울시 노원구 초안산로 12"
    
    @IBOutlet weak var addressEditTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressEditTableView.delegate = self
        addressEditTableView.dataSource = self
        self.title = "주소 관리"
        
        getAdressEditData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleAddressDataUpdated(_:)), name: NSNotification.Name("AddressDataUpdated"), object: nil)
    }
    
    @objc func handleAddressDataUpdated(_ notification: Notification) {
        getAdressEditData()
        addressEditTableView.reloadData()
    }
    
    func getAdressEditData() {
        if let token = UserTokenManager.shared.getToken() {
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            AF.request(url, headers: headers).responseDecodable(of: [AddressData].self) { response in
                switch response.result {
                case .success(let addressData):
                    // 요청이 성공한 경우
                    self.addressData = addressData.first?.addressList ?? []
                    self.addressEditTableView.reloadData()
                case .failure(let error):
                    // 요청이 실패한 경우
                    print("Error: \(error.localizedDescription)")
                }
            }
        } else {
            print("Token not available.")
        }
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        let tappedIndexPath = IndexPath(row: sender.tag, section: 0)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let editMoreAddressVC = storyboard.instantiateViewController(withIdentifier: "EditMoreAdress") as? EditMoreAdressViewController {
            if tappedIndexPath.row == 0 {
                // 첫 번째 셀 (집)을 편집하는 경우
                editMoreAddressVC.indexPath = tappedIndexPath
                editMoreAddressVC.titleText = homeTitle
                editMoreAddressVC.adressText = homeAddress
                editMoreAddressVC.adressText = homeAddress
                editMoreAddressVC.isHome = true
                editMoreAddressVC.nickname = nil
            } else {
                // 다른 주소 셀을 편집하는 경우
                let otherAddressIndex = tappedIndexPath.row - 1
                editMoreAddressVC.indexPath = tappedIndexPath
                editMoreAddressVC.titleText = addressData[otherAddressIndex].addressName
                editMoreAddressVC.adressText = addressData[otherAddressIndex].addressDetail
                editMoreAddressVC.adressText = addressData[otherAddressIndex].addressDetail
                editMoreAddressVC.isHome = false
                editMoreAddressVC.nickname = addressData[otherAddressIndex].addressName
            }
            
            self.navigationController?.pushViewController(editMoreAddressVC, animated: true)
        }
    }
    
    @IBAction func delBtnTap(_ sender: UIButton) {
        let buttonTag = sender.tag
        let indexPath = IndexPath(row: buttonTag, section: 0)
        
        // 알림창 생성
        let alertController = UIAlertController(title: "주소 삭제", message: "이 주소를 삭제하시겠습니까?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] (action) in
            // 주소를 삭제하는 작업을 수행
            // 작업 후 테이블 뷰를 업데이트해야 할 수 있습니다.
            
            if indexPath.row == 0 {
                self?.homeTitle = "우리 집"
                self?.homeAddress = ""
            } else {
                let otherAddressIndex = indexPath.row - 1
                self?.addressData.remove(at: otherAddressIndex)
            }
            
            // 삭제 작업 후 테이블 뷰 업데이트
            self?.addressEditTableView.reloadData()
        }
        
        // 액션을 알림창에 추가
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        // 알림창 표시
        present(alertController, animated: true, completion: nil)
    }
}

extension AdressEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택한 경우 처리
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension AdressEditViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + addressData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let editHomeCell = tableView.dequeueReusableCell(withIdentifier: "editHomeCell", for: indexPath) as! EditHomeTableViewCell
            
            editHomeCell.editHomeTitleLabel.text = homeTitle
            editHomeCell.editHomeAdressLabel.text = homeAddress
            
            let houseImage = UIImage(systemName: "house")
            editHomeCell.editHomeImageView.image = houseImage
            
            return editHomeCell
        } else {
            let editOtherCell = tableView.dequeueReusableCell(withIdentifier: "editOtherCell", for: indexPath) as! EditOtherAdressTableViewCell
            
            let otherAddressIndex = indexPath.row - 1
            editOtherCell.editOtherTitleLabel.text = addressData[otherAddressIndex].addressName
            editOtherCell.editOtherAdressLabel.text = addressData[otherAddressIndex].addressDetail
            
            let addressImage = UIImage(systemName: "mappin.and.ellipse")
            editOtherCell.editOtherImageView.image = addressImage
            
            editOtherCell.editOtherEditBtn.tag = indexPath.row
            editOtherCell.editOtherDelBtn.tag = indexPath.row
            
            return editOtherCell
        }
    }
}
