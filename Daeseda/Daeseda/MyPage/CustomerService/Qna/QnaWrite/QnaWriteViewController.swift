import UIKit
import Alamofire

class QnaWriteViewController: UIViewController {
    
    let url = "http://localhost:8888/board/register"
    let textViewPlaceHolder = "텍스트를 입력하세요"
    
    @IBOutlet weak var qnaWriteContentTV: UITextView!
    @IBOutlet weak var qnaWriteCategoryTF: UITextField!
    @IBOutlet weak var qnaWriteTitleTF: UITextField!
    
    // 카테고리 목록
    let categories = ["일반", "수거/배송", "결제", "서비스", "품질 불만", "기타"]
    
    // 피커뷰 선택한 카테고리 저장 변수
    var selectedCategory: String?
    var pickerView: UIPickerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.qnaWriteContentTV.layer.borderWidth = 1.0
        self.qnaWriteContentTV.layer.borderColor = UIColor.lightGray.cgColor
        
        // 텍스트 뷰에 플레이스홀더 기능 추가
        qnaWriteContentTV.addPlaceHolder(textViewPlaceHolder)
        qnaWriteContentTV.delegate = self
        
        let qnaWritePostBtnItem = UIBarButtonItem(
            title: "등록",
            style: .plain,
            target: self,
            action: #selector(qnaWritePostBtn)
        )
        navigationItem.rightBarButtonItem = qnaWritePostBtnItem
        
        // 키보드 내리기 제스처를 추가
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // qnaWriteCategoryTF 텍스트 필드를 수정 가능하도록 설정
        qnaWriteCategoryTF.isUserInteractionEnabled = true
    }
    
    @objc func dismissKeyboard() {
        // 텍스트 필드 또는 텍스트 뷰에서 편집 중인 경우, 키보드를 내립니다.
        view.endEditing(true)
    }
    
    @objc func qnaWritePostBtn() {
        // 텍스트 필드에서 값을 가져와서 QnaWriteData 구조체에 할당
        guard let category = qnaWriteCategoryTF.text,
              let title = qnaWriteTitleTF.text,
              let content = qnaWriteContentTV.text, content != textViewPlaceHolder else {
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
    
    @IBAction func qnaCategoryBtn(_ sender: UIButton) {
        createPickerView()
        qnaWriteCategoryTF.becomeFirstResponder() // 텍스트 필드를 편집 모드로 전환
    }
    
    func createPickerView() {
        pickerView = UIPickerView()
        pickerView?.dataSource = self
        pickerView?.delegate = self
        qnaWriteCategoryTF.text = categories[0]  // 초기 선택 카테고리
        qnaWriteCategoryTF.inputView = pickerView  // 텍스트 필드에 피커뷰를 입력뷰로 지정
        createToolbar()
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "선택", style: .done, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        
        qnaWriteCategoryTF.inputAccessoryView = toolBar  // 텍스트 필드의 액세서리뷰로 툴바를 지정
    }
    
    @objc func doneButtonTapped() {
        qnaWriteCategoryTF.resignFirstResponder()  // 피커뷰와 툴바 닫기
    }
}

// UITextViewDelegate를 활용하여 플레이스홀더 처리
extension UITextView {
    func addPlaceHolder(_ placeholder: String) {
        self.text = placeholder
        self.textColor = UIColor.lightGray
    }
}

extension QnaWriteViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = UIColor.lightGray
        }
    }
}

extension QnaWriteViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
        qnaWriteCategoryTF.text = categories[row]
        selectedCategory = categories[row]
    }
}
