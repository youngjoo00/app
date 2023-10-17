import UIKit
import Alamofire

struct QnaWriteData: Codable {
    var boardCategory: String
    var boardTitle: String
    var boardContent: String
}

class QnaWriteViewController: UIViewController {
    
    let url = "http://localhost:8888/board/register"
    
    @IBOutlet weak var qnaWriteCategoryTF: UITextField!
    @IBOutlet weak var qnaWriteContentTF: UITextField!
    @IBOutlet weak var qnaWriteTitleTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let qnaWritePostBtnItem = UIBarButtonItem(
            title: "등록",
            style: .plain,
            target: self,
            action: #selector(qnaWritePostBtn)
        )
        navigationItem.rightBarButtonItem = qnaWritePostBtnItem
    }
    
    @objc func qnaWritePostBtn() {
        // 텍스트 필드에서 값을 가져와서 QnaWriteData 구조체에 할당
        guard let category = qnaWriteCategoryTF.text,
              let title = qnaWriteTitleTF.text,
              let content = qnaWriteContentTF.text else {
            print("모든 필드를 채워주세요.")
            return
        }
        
        let qnaData = QnaWriteData(boardCategory: category, boardTitle: title, boardContent: content)
        
        if let token = UserTokenManager.shared.getToken() {
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            AF.request(url, method: .post, parameters: qnaData, encoder: JSONParameterEncoder.default, headers: headers)
                .response { response in
                    switch response.result {
                    case .success:
                        print("등록 성공")
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print("등록 실패: \(error.localizedDescription)")
                    }
                }
        } else {
            print("Token not available.")
        }
    }
}
