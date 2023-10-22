import UIKit
import Alamofire

class AdressEditViewController: UIViewController {
    
    let url = "http://localhost:8888/users/address/list"
    
    var selectedIndexPath: IndexPath?
    var addressData = [Address]()
    
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
            
            AF.request(url, headers: headers).responseDecodable(of: [Address].self) { response in
                switch response.result {
                case .success(let addressData):
                    // 요청이 성공한 경우
                    self.addressData = addressData
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
            let otherAddressIndex = tappedIndexPath.row
            
            editMoreAddressVC.indexPath = tappedIndexPath
            editMoreAddressVC.titleText = addressData[otherAddressIndex].addressName
            editMoreAddressVC.roadAddressText = addressData[otherAddressIndex].addressRoad
            editMoreAddressVC.detailAdressText = addressData[otherAddressIndex].addressDetail
            editMoreAddressVC.nickname = addressData[otherAddressIndex].addressName
            
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
            
            let otherAddressIndex = indexPath.row
            
            self?.addressData.remove(at: otherAddressIndex)
            
            let delUrl = "http://localhost:8888/users/address/delete"
            
            // 1. 토큰 가져오기
            if let token = UserTokenManager.shared.getToken() {
                
                // 2. Bearer Token을 설정합니다.
                let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
                
                // 3. 서버에서 삭제 요청을 보냅니다.
                AF.request(delUrl, method: .delete, headers: headers).response { response in
                    switch response.result {
                    case .success:
                        // 요청이 성공한 경우
                        print("userDel Successful")
                        
                        // 토큰 삭제
                        UserTokenManager.shared.clearToken()
                        
                    case .failure(let error):
                        // 요청이 실패한 경우
                        print("Error: \(error.localizedDescription)")
                    }
                }
            } else {
                print("Token not available.")
            }
            
            // 삭제 작업 후 테이블 뷰 업데이트
            self?.addressEditTableView.reloadData()
        }
        
        // 액션을 알림창에 추가
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        
        // 알림창 표시
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 탭 바를 숨깁니다.
        tabBarController?.tabBar.isHidden = true
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
        return addressData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let editOtherCell = tableView.dequeueReusableCell(withIdentifier: "editOtherCell", for: indexPath) as! EditOtherAdressTableViewCell
        
        let otherAddressIndex = indexPath.row
        editOtherCell.editOtherTitleLabel.text = addressData[otherAddressIndex].addressName
        editOtherCell.editOtherAdressLabel.text = addressData[otherAddressIndex].addressDetail
        
        let addressImage = UIImage(systemName: "mappin.and.ellipse")
        editOtherCell.editOtherImageView.image = addressImage
        
        editOtherCell.editOtherEditBtn.tag = indexPath.row
        editOtherCell.editOtherDelBtn.tag = indexPath.row
        
        return editOtherCell
    }
}
