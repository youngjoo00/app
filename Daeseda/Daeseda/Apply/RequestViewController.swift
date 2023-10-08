//
//  RequestViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/16.
//

import UIKit

class RequestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.isHidden = true
        
        nextButton()
        textLabel()
        setupDatePicker()
        setupToolBar()
        
        //선택옵션 기능에 이용할 UIButton 배열 추가
        ButtonArray.append(generalButton)
        ButtonArray.append(specialButton)
        
    }
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()
    
    @IBOutlet weak var generalButton: UIButton!
    @IBOutlet weak var specialButton: UIButton!
    var ButtonArray = [UIButton]()
    
    var way : String = ""
    
    func nextButton(){
        var nextButton = UIButton()
        nextButton.frame = CGRect(x: 0, y: 0, width: 250, height: 34)
        nextButton.layer.backgroundColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1).cgColor
        nextButton.layer.cornerRadius = 10
        
        self.view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 34).isActive = true
        nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50).isActive = true
        nextButton.addTarget(self, action: #selector(requestInfoVC), for: .touchUpInside)
        
        
        let naxtText = UILabel()
        naxtText.frame = CGRect(x: 0, y: 0, width: 37, height: 27)
        naxtText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        naxtText.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        naxtText.textAlignment = .center
        naxtText.text = "다음"
        
        self.view.addSubview(naxtText)
        naxtText.translatesAutoresizingMaskIntoConstraints = false
        naxtText.widthAnchor.constraint(equalToConstant: 37).isActive = true
        naxtText.heightAnchor.constraint(equalToConstant: 27).isActive = true
        naxtText.centerXAnchor.constraint(equalTo: nextButton.centerXAnchor).isActive = true
        naxtText.centerYAnchor.constraint(equalTo: nextButton.centerYAnchor).isActive = true
    }
    @objc func requestInfoVC() {
        guard  let requestInfoVC = storyboard?.instantiateViewController(withIdentifier: "requestInfo") as? RequestInfoViewController else { return }
        requestInfoVC.selectDate = self.dateTextField.text!
        requestInfoVC.selectTime = self.timeTextField.text!
        requestInfoVC.selectWay = self.way
        
        self.navigationController?.pushViewController(requestInfoVC, animated: true)
    }
    
    func textLabel() {
        
        let title = UILabel()
        title.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        title.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        title.font = UIFont(name: "GmarketSansTTFMedium", size: 30)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        // Line height: 25 pt
        title.text = "쉽고 간편한\n세탁 서비스"
        
        self.view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 38).isActive = true
        title.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        
        let subTitle = UILabel()
        subTitle.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        subTitle.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        subTitle.font = UIFont(name: "GmarketSansTTFLight", size: 15)
        subTitle.numberOfLines = 0
        subTitle.lineBreakMode = .byWordWrapping
        // Line height: 25 pt
        subTitle.text = "양식에 맞추어 정보를 입력하세요."
        
        self.view.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 38).isActive = true
        subTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 170).isActive = true
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 0, y: 0, width: 56, height: 27)
        dateLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        dateLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        dateLabel.textAlignment = .center
        dateLabel.text = "수거일"
        
        self.view.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        dateLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 225).isActive = true
        
        let timeLabel = UILabel()
        timeLabel.frame = CGRect(x: 0, y: 0, width: 37, height: 27)
        timeLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        timeLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        timeLabel.textAlignment = .center
        timeLabel.text = "시간"
        
        self.view.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        timeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 290).isActive = true
        
        // Auto layout, variables, and unit scale are not yet supported
        let typeLabel = UILabel()
        typeLabel.frame = CGRect(x: 0, y: 0, width: 74, height: 27)
        typeLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        typeLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        typeLabel.textAlignment = .center
        typeLabel.text = "세탁종류"
        
        self.view.addSubview(typeLabel)
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        typeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 355).isActive = true
    }
    
    func setupToolBar() {
        
        let dateToolBar = UIToolbar()
        let timeToolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let dateDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dateDoneButtonHandeler))
        let timeDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(timeDoneButtonHandeler))
        
        dateToolBar.items = [flexibleSpace, dateDoneButton]
        dateToolBar.sizeToFit()
        
        timeToolBar.items = [flexibleSpace, timeDoneButton]
        timeToolBar.sizeToFit()
        
        // textField의 경우 클릭 시 키보드 위에 AccessoryView가 표시됨.
        dateTextField.inputAccessoryView = dateToolBar
        timeTextField.inputAccessoryView = timeToolBar
    }
    
    @objc func dateDoneButtonHandeler(_ sender: UIBarButtonItem) {
        
        dateTextField.text = dateFormat(date: datePicker.date)
        
        // 키보드 내리기
        dateTextField.resignFirstResponder()
    }
    
    @objc func timeDoneButtonHandeler(_ sender: UIBarButtonItem) {
        
        timeTextField.text = timeFormat(date: timePicker.date)
        // 키보드 내리기
        timeTextField.resignFirstResponder()
    }
    
    @IBAction func selectOptionBtnAction(_ sender: UIButton) {
        for Btn in ButtonArray {
            if Btn == sender {
                Btn.isSelected = true
                Btn.tintColor = UIColor(red: 0.365, green: 0.553, blue: 0.949, alpha: 1)
                
                switch sender {
                case generalButton : way = "일반세탁"
                default : way = "특수세탁"
                }
            } else {
                Btn.isSelected = false
                Btn.tintColor = UIColor.black
            }
        }
        print(way)
    }
}
extension RequestViewController : UITextFieldDelegate{
    private func dateFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy / MM / dd"
        
        return formatter.string(from: date)
    }
    
    private func timeFormat(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h:mm"
        
        return formatter.string(from: date)
    }
    
    func setupDatePicker() {
        
        // Moded - time, date, dateAndTime, countDownTimer
        datePicker.datePickerMode = .date
        timePicker.datePickerMode = .time
        
        // 스타일 - wheels, inline, compact, automatic
        datePicker.preferredDatePickerStyle = .wheels
        timePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko-KR")
        
        // 값이 변할 때마다 동작을 설정
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        timePicker.addTarget(self, action: #selector(timeChange), for: .valueChanged)
        
        // inputView가 nil이라면 기본 할당은 키보드
        dateTextField.inputView = datePicker
        timeTextField.inputView = timePicker
        
    }
    
    // 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        dateTextField.text = dateFormat(date: sender.date)
    }
    @objc func timeChange(_ sender: UIDatePicker) {
        timeTextField.text = timeFormat(date: sender.date)
    }
    
}
