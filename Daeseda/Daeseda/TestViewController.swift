
import UIKit

class testViewController: UIViewController {

    let names = [
        "대세다 서비스 이용약관",
        "개인정보 처리방침",
        "회사 정보",
        "버전"
    ]
    
    @IBOutlet weak var testTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testTableView.dataSource = self
        testTableView.delegate = self
    }


}

extension testViewController: UITableViewDelegate {

    // 셀을 클릭했을때 발동하는 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hi!")
    }
}

extension testViewController: UITableViewDataSource {
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let testCell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath)
        
        testCell.textLabel?.text = names[indexPath.row]
        
        return testCell
    }
    
    
}
