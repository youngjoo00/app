import UIKit

class AdressEditViewController: UIViewController {
    
    var indexPath: IndexPath?
    
    let homeTitle = "우리 집"
    let homeAdress = "서울시 노원구 초안산로 12"

    let otherAdressTitles = [
        "회사",
        "한강공원",
        "다른 주소 1",
    ]

    let otherAdressAdresses = [
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
        let indexPath = IndexPath(row: sender.tag, section: 0)

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let moreAdressVC = storyboard.instantiateViewController(withIdentifier: "MoreAdressVC") as? MoreAdressViewController {
            moreAdressVC.indexPath = indexPath
            self.navigationController?.pushViewController(moreAdressVC, animated: true)
        }
    }


}


extension AdressEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
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
            
            return EditOtherCell
        }
    }
    
}
