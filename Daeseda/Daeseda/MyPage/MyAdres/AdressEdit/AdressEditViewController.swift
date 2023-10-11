import UIKit

class AdressEditViewController: UIViewController {
    
    var indexPath: IndexPath?
    var titleText: String?
    var addressText: String?
    var isHome: Bool?
    var nickname: String?
    
    var homeTitle = "우리 집"
    var homeAdress = "서울시 노원구 초안산로 12"
    
    var otherAdressTitles = [
        "회사",
        "한강공원",
        "다른 주소 1",
    ]
    
    var otherAdressAdresses = [
        "서울시 노원구 초안산로 12 인관 301호",
        "서울 잠실 뭐시기",
        "다른 주소 1의 주소",
    ]
    
    @IBOutlet weak var adressEditTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adressEditTableView.delegate = self
        adressEditTableView.dataSource = self
        
        self.title = "주소 관리"
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        let tappedIndexPath = IndexPath(row: sender.tag, section: 0)
        
        print(tappedIndexPath.row)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let editMoreAdressVC = storyboard.instantiateViewController(withIdentifier: "EditMoreAdressVC") as? EditMoreAdressViewController {
            if tappedIndexPath.row == 0 {
                // 첫 번째 셀 (집)을 편집하는 경우
                editMoreAdressVC.indexPath = tappedIndexPath
                editMoreAdressVC.titleText = homeTitle
                editMoreAdressVC.adressText = homeAdress
                editMoreAdressVC.isHome = true
                editMoreAdressVC.nickname = nil  // 첫 번째 셀에는 닉네임이 필요 없음
            } else {
                // 다른 주소 셀을 편집하는 경우
                let otherAdressIndex = tappedIndexPath.row - 1
                editMoreAdressVC.indexPath = tappedIndexPath
                editMoreAdressVC.titleText = otherAdressTitles[otherAdressIndex]
                editMoreAdressVC.adressText = otherAdressAdresses[otherAdressIndex]
                editMoreAdressVC.isHome = false
                editMoreAdressVC.nickname = otherAdressTitles[otherAdressIndex]
            }
            
            self.navigationController?.pushViewController(editMoreAdressVC, animated: true)
        }
    }
    
    @IBAction func delBtnTap(_ sender: UIButton) {
            // 버튼의 tag로 indexPath를 구합니다.
            let buttonTag = sender.tag
            let indexPath = IndexPath(row: buttonTag, section: 0)
            
            print(indexPath.row)

            // 알림창 생성
            let alertController = UIAlertController(title: "주소 삭제", message: "이 주소를 삭제하시겠습니까?", preferredStyle: .alert)
            
            // 취소 액션
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            // 삭제 액션
            let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] (action) in
                // 여기에서 주소를 삭제하는 작업을 수행
                // 삭제 작업을 수행한 후 테이블 뷰를 업데이트해야 할 수 있습니다.
                
                if indexPath.row == 0 {
                    // 첫 번째 셀 (집) 삭제 작업을 시뮬레이션하는 경우
                    self?.homeTitle = "우리 집"
                    self?.homeAdress = ""
                } else {
                    // 다른 주소 셀 삭제 작업을 시뮬레이션하는 경우
                    let otherAdressIndex = indexPath.row - 1
                    self?.otherAdressTitles.remove(at: otherAdressIndex)
                    self?.otherAdressAdresses.remove(at: otherAdressIndex)
                }
                
                // 삭제 작업을 수행한 후 테이블 뷰를 업데이트
                self?.adressEditTableView.reloadData()
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
        // Handle selection if needed
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
        return 1 + otherAdressTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let editHomeCell = tableView.dequeueReusableCell(withIdentifier: "editHomeCell", for: indexPath) as! EditHomeTableViewCell
            
            editHomeCell.editHomeTitleLabel.text = homeTitle
            editHomeCell.editHomeAdressLabel.text = homeAdress
            
            let houseImage = UIImage(systemName: "house")
            editHomeCell.editHomeImageView.image = houseImage
            
            return editHomeCell
        } else {
            let EditOtherCell = tableView.dequeueReusableCell(withIdentifier: "editOtherCell", for: indexPath) as! EditOtherAdressTableViewCell
            
            let otherAdressIndex = indexPath.row - 1
            EditOtherCell.editOtherTitleLabel.text = otherAdressTitles[otherAdressIndex]
            EditOtherCell.editOtherAdressLabel.text = otherAdressAdresses[otherAdressIndex]
            
            let adressImage = UIImage(systemName: "mappin.and.ellipse")
            EditOtherCell.editOtherImageView.image = adressImage
            
            // 버튼의 tag를 설정하여 IndexPath를 관리
            EditOtherCell.editOtherEditBtn.tag = indexPath.row
            
            EditOtherCell.editOtherDelBtn.tag = indexPath.row
            return EditOtherCell
        }
    }
}
