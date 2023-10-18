//
//  RequestInfoViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/09/16.
//

import UIKit
import Alamofire

class RequestInfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel()
        setupPlacePicker()
        setupToolBar()
        endButton()
        
        addressTextField.isEnabled = false
        
        print(selectedClothesCount)
    }
    
    var selectDate : String = ""
    var selectTime : String = ""
    var selectWay : String = ""
    var deliveryDate : String = ""
    var totalPrdeliveryLocationice : String = ""
    var selectedClothesCount: [ClothesCount] = []
    var deliveryLocation : String = ""
    var selectedAddress: [Address] = []
    
    var addressInfo = Address(addressId: 0, addressName: "집", addressDetail: "경기도 동두천시", addressZipcode: "12345")
    
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var addressDetailTextField: UITextField!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var etcTextField: UITextField!
    
    let placePicker = UIPickerView()
    let place = ["현관문 앞(공동현관X)", "현관문 앞(공동현관O)", "경비실", "기타"]
    
    @IBAction func addressSearchButton(_ sender: Any) {
        guard let addressSearchVC = storyboard?.instantiateViewController(withIdentifier: "addressSearch") as? AddressSearchViewController else { return }
        self.present(addressSearchVC, animated: true)
    }
    
    @objc func addressNotification(_ notification: Notification) {
        if let data = notification.userInfo as? [String: Any] {
            if let address = data["address"] as? String,
               let zonecode = data["zonecode"] as? String {
                addressTextField.text = address
                addressInfo = Address(addressId: 0, addressName: "", addressDetail: address, addressZipcode: zonecode)
                self.dismiss(animated: true, completion: nil)
                
            }
        }
    }
    
    @IBAction func goAddress(_ sender: Any) {
        guard let addressVC = storyboard?.instantiateViewController(withIdentifier: "MyAdress") as? MyAdressViewController else { return }
        self.present(addressVC, animated: true)
    }
    
    @objc func postAddressData(_ notification: Notification) {
        if let data = notification.userInfo as? [String: Any] {
            if let address = data["address"] as? String,
               let zonecode = data["zonecode"] as? String {
                addressTextField.text = address
                addressInfo = Address(addressId: 0, addressName: "", addressDetail: address, addressZipcode: zonecode)
                self.dismiss(animated: true, completion: nil)
                
            }
        }
    }
    
    func textLabel(){
        
        let nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 0, y: 0, width: 37, height: 27)
        nameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        nameLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        nameLabel.textAlignment = .center
        nameLabel.text = "이름"
        
        let addressLabel = UILabel()
        addressLabel.frame = CGRect(x: 0, y: 0, width: 131, height: 27)
        addressLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        addressLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        addressLabel.text = "수거/배송주소"
        
        self.view.addSubview(addressLabel)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.widthAnchor.constraint(equalToConstant: 131).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        addressLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 220).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(addressNotification(_:)), name: NSNotification.Name("postAddressNotification"), object: nil)
        
        let placeLabel = UILabel()
        placeLabel.frame = CGRect(x: 0, y: 0, width: 131, height: 27)
        placeLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        placeLabel.font = UIFont(name: "NotoSans-Regular", size: 20)
        // Line height: 27.24 pt
        placeLabel.text = "베송 위치"
        
        self.view.addSubview(placeLabel)
        placeLabel.translatesAutoresizingMaskIntoConstraints = false
        placeLabel.widthAnchor.constraint(equalToConstant: 131).isActive = true
        placeLabel.heightAnchor.constraint(equalToConstant: 27).isActive = true
        placeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 35).isActive = true
        placeLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 320).isActive = true
        
    }
    
    func endButton(){
        let nextButton = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(endVC))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    @objc func endVC() {
        
        totalPrdeliveryLocationice =  "\(placeTextField.text!), \(etcTextField.text!)"
        
        let alert = UIAlertController(title:"완료되었습니다!",message: "세탁 주문이 완료되었습니다. \n이후 결제를 진행해주세요.",preferredStyle: UIAlertController.Style.alert)
        
        let newOrder = Order(address: addressInfo, clothesCount: selectedClothesCount, totalPrice: 0, washingMethod: self.selectWay, pickupDate: self.selectDate, deliveryDate: self.deliveryDate, deliveryLocation: totalPrdeliveryLocationice)
        
        
        //확인 버튼 만들기
        let ok = UIAlertAction(title: "확인", style: .default, handler: { action in
            //            AF.request(self.url, method: .post, parameters: userData, encoder: JSONParameterEncoder.default)
            //                .validate(statusCode: 200..<300)
            //                .response { response in
            //                    switch response.result {
            //                    case .success:
            //                        // status code만 뽑아오기
            //                        if let statusCode = response.response?.statusCode {
            //                            print("HTTP Status Code: \(statusCode)")
            //                            print("response 란 무엇인가 : \(response)")
            //                            print("response.response 란 무엇인가 : \(response.response!)")
            //                            print("\n")
            //                        }
            //
            //                        // 헤더 값 뽑아오기
            //                        if let responseHeaders = response.response?.allHeaderFields as? [String: String] {
            //                            for (key, value) in responseHeaders {
            //                                print("Header \(key): \(value)")
            //                            }
            //                        }
            //
            //
            //                    case .failure(let error):
            //                        print("Error: \(error)")
            //                    }
            //                }
            
            print(newOrder)
        })
        
        //확인 버튼 경고창에 추가하기
        alert.addAction(ok)
        present(alert,animated: true,completion: nil)
    }
}

// 배송 장소 선택
extension RequestInfoViewController : UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return place.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return place[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        placeTextField.text = place[row]
        
        let select = place[row]
        if select == "기타" {
            etcTextField.isEnabled = true // 텍스트 필드 활성화
            etcTextField.placeholder = "장소를 입력해주세요."
        } else if select == "현관문 앞(공동현관O)" {
            etcTextField.isEnabled = true // 텍스트 필드 활성화
            etcTextField.placeholder = "공동현관 비밀번호를 입력해주세요."
        } else {
            etcTextField.isEnabled = false
            etcTextField.placeholder = ""
            etcTextField.text = ""
        }
    }
    
    func setupPlacePicker() {
        placePicker.delegate = self
        placeTextField.inputView = placePicker
    }
    
    func setupToolBar() {
        
        let palceToolBar = UIToolbar()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let placeDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(placeDoneButtonHandeler))
        
        
        palceToolBar.items = [flexibleSpace, placeDoneButton]
        palceToolBar.sizeToFit()
        
        // textField의 경우 클릭 시 키보드 위에 AccessoryView가 표시됨.
        placeTextField.inputAccessoryView = palceToolBar
    }
    
    @objc func placeDoneButtonHandeler(_ sender: UIBarButtonItem) {
        
        // 키보드 내리기
        placeTextField.resignFirstResponder()
    }
    
    @IBAction func etcTextFieldEditingDidEnd(_ sender: Any) {
        let etc = etcTextField.text
        let place = placeTextField.text
        
    }
}
