import UIKit
import Alamofire

class QnaEditViewController: UIViewController {
    
    @IBOutlet weak var qnaEditContentTV: UITextView!
    @IBOutlet weak var qnaEditCategoryTF: UITextField!
    @IBOutlet weak var qnaEditTitleTF: UITextField!
    
    var qnaEditId: Int?
    var qnaEditContent: String?
    var qnaEditCategory: String?
    var qnaEditTitle: String?
    
    // 카테고리 목록
    let categories = ["일반", "수거/배송", "결제", "서비스", "품질 불만", "기타"]
    let textViewPlaceHolder = "텍스트를 입력하세요"
    
    // 피커뷰 선택한 카테고리 저장 변수
    var selectedCategory: String?
    var pickerView: UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.qnaEditContentTV.layer.borderWidth = 1.0
        self.qnaEditContentTV.layer.borderColor = UIColor.lightGray.cgColor
        
        let qnaEditBtnItem = UIBarButtonItem(
            title: "등록",
            style: .plain,
            target: self,
            action: #selector(qnaEditBtn)
        )
        navigationItem.rightBarButtonItem = qnaEditBtnItem
        
        // 키보드 내리기 제스처를 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // qnaWriteCategoryTF 텍스트 필드를 수정 가능하도록 설정
        qnaEditCategoryTF.isUserInteractionEnabled = true
        
        updateUI()
    }
    
    @objc func dismissKeyboard() {
        // 텍스트 필드 또는 텍스트 뷰에서 편집 중인 경우, 키보드를 내립니다.
        view.endEditing(true)
    }
    
    @objc func qnaEditBtn() {
        
        if let qnaEditId = self.qnaEditId {
            // 옵셔널 바인딩 내부에서 qnaEditId를 사용하여 URL을 생성
            let url = "http://localhost:8888/board/\(qnaEditId)"
            
            // 나머지 코드는 그대로 유지
            guard let category = qnaEditCategoryTF.text,
                  let title = qnaEditTitleTF.text,
                  let content = qnaEditContentTV.text, content != textViewPlaceHolder else {
                print("모든 필드를 채워주세요.")
                return
            }
            
            let qnaData = QnaEditData(boardId: qnaEditId, boardCategory: category, boardTitle: title, boardContent: content)
            
            if let token = UserTokenManager.shared.getToken() {
                let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
                
                AF.request(url, method: .put, parameters: qnaData, encoder: JSONParameterEncoder.default, headers: headers)
                    .response { response in
                        switch response.result {
                        case .success:
                            print("수정 성공")
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


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 탭 바를 숨깁니다.
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // 다른 화면으로 이동할 때 탭 바를 다시 보이게 합니다.
        tabBarController?.tabBar.isHidden = false
        self.navigationItem.title = .none
    }
    
    func updateUI() {
        qnaEditTitleTF.text = qnaEditTitle
        qnaEditContentTV.text = qnaEditContent
        qnaEditCategoryTF.text = qnaEditCategory
    }
    
    @IBAction func qnaCategoryBtn(_ sender: UIButton) {
        createPickerView()
        qnaEditCategoryTF.becomeFirstResponder() // 텍스트 필드를 편집 모드로 전환
    }
    
    func createPickerView() {
        pickerView = UIPickerView()
        pickerView?.dataSource = self
        pickerView?.delegate = self
        qnaEditCategoryTF.text = categories[0]  // 초기 선택 카테고리
        qnaEditCategoryTF.inputView = pickerView  // 텍스트 필드에 피커뷰를 입력뷰로 지정
        createToolbar()
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        
        qnaEditCategoryTF.inputAccessoryView = toolBar  // 텍스트 필드의 액세서리뷰로 툴바를 지정
    }
    
    @objc func doneButtonTapped() {
        qnaEditCategoryTF.resignFirstResponder()  // 피커뷰와 툴바 닫기
    }


}

extension QnaEditViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        qnaEditCategoryTF.text = categories[row]
        selectedCategory = categories[row]
    }
}

protocol QnaEditDelegate: AnyObject {
    func didEditQna(title: String, content: String, category: String)
}
