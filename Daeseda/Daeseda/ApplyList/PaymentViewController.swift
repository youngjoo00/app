//
//  PaymentViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/08.
//

import UIKit
import TossPayments

struct DefaultPaymentRequest : Codable{
    var amount : Int
    var orderId : String
    var orderName : String
}

class PaymentViewController: UIViewController {
    
    private lazy var widget: PaymentWidget = PaymentWidget(
        clientKey: "test_ck_DLJOpm5QrlxB21Qen2LrPNdxbWnY",
        customerKey: "test_sk_Poxy1XQL8RgbOm7JRk437nO5Wmlg"
    )
    
    public lazy var scrollView = UIScrollView()
    public lazy var stackView = UIStackView()
    private lazy var button = UIButton()
    
    public var scrollViewBottomAnchorConstraint: NSLayoutConstraint?
    
    
    var amount: Int = 0
//    var orderId: String = "2VAhXURbYbiKwX5ybfrLr", a4CWyWY5m89PNxh7xJwhk1
    var orderId: String = "a4CWyWY5m89PNxh7xJwhk3"
    var orderName: String = "대세다-대신 세탁해드립니다."
    
    var cardName: String = ""
    var cardNumber: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(amount)
        print(orderId)
        print(orderName)
        widget.delegate = self
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        
        stackView.spacing = 24
        stackView.axis = .vertical
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -24),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -48),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        view.addSubview(button)
        button.setTitle("결제하기", for: .normal)
        button.addTarget(self, action: #selector(requestPayment), for: .touchUpInside)
        
        let paymentMethods = widget.renderPaymentMethods(amount: PaymentMethodWidget.Amount(value: Double(self.amount)))
        let agreement = widget.renderAgreement()
        
        stackView.addArrangedSubview(paymentMethods)
        stackView.addArrangedSubview(agreement)
        stackView.addArrangedSubview(button)
        
        // 추가된 코드
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true // 버튼의 높이 설정
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.setTitle("결제하기", for: .normal)

        // 버튼을 뷰에 직접 추가
        view.addSubview(button)

        // 버튼의 위치와 크기 제약을 설정
        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        
    }
    
    @objc func requestPayment() {
        widget.requestPayment(info: DefaultWidgetPaymentInfo(
            orderId: self.orderId,
            orderName: self.orderName))
        
        fetchDataForOrderId(orderId: self.orderId)

    }

    
}
extension PaymentViewController: TossPaymentsDelegate {

    public func didReceivedLoad(_ name: String) {
        print("결제위젯 렌더링 완료 ")
    }

    public func handleSuccessResult(_ success: TossPaymentsResult.Success) {
        print("결제 성공")
        print(success)
        postData(paymentKey: success.paymentKey, orderId: self.orderId, amount: self.amount)
        fetchDataForOrderId(orderId: self.orderId)
        
        self.dismiss(animated: true, completion: nil)
    }

    public func handleFailResult(_ fail: TossPaymentsResult.Fail) {
        print("결제 실패")
        print("errorCode: \(fail.errorCode)")
        print("errorMessage: \(fail.errorMessage)")
        print("orderId: \(fail.orderId)")

    }
    
    func postData(paymentKey:String, orderId : String, amount: Int){
        let urlString = "https://api.tosspayments.com/v1/payments/confirm"
//        let paymentKey = "5zJ4xY7m0kODnyRpQWGrN2xqGlNvLrKwv1M9ENjbeoPaZdL6"
//        let orderId = "a4CWyWY5m89PNxh7xJwhk1"
//        let amount = 15000
        let authorizationHeader = "Basic dGVzdF9za19Qb3h5MVhRTDhSZ2JPbTdKUms0MzduTzVXbWxnOg=="
        let idempotencyKey = "a6a498c4-6f61-4183-a2ff-80176e69a067"

        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // 설정할 헤더들
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue(authorizationHeader, forHTTPHeaderField: "Authorization")
            request.setValue(idempotencyKey, forHTTPHeaderField: "Idempotency-Key")
            
            // 요청 본문 데이터
            let requestBody: [String: Any] = ["paymentKey": paymentKey, "orderId": orderId, "amount": amount]
            if let jsonData = try? JSONSerialization.data(withJSONObject: requestBody) {
                request.httpBody = jsonData
            }
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("PostResponse: \(responseString)")
                    }
                }
            }
            
            task.resume()
        } else {
            print("Invalid URL")
        }
    }
    
    func fetchDataForOrderId(orderId: String) {
        // 기본 URL
        let baseUrlString = "https://api.tosspayments.com/v1/payments/orders"

        // URL 구성
        if let url = URL(string: "\(baseUrlString)/\(orderId)") {
            var request = URLRequest(url: url)

            // HTTP 메서드 설정
            request.httpMethod = "GET"

            // Authorization 헤더 설정
            let credentials = "dGVzdF9za196WExrS0V5cE5BcldtbzUwblgzbG1lYXhZRzVSOg=="
            request.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                } else if let data = data {
                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response: \(responseString)")
                    }
                }
            }

            task.resume()
        } else {
            print("Invalid URL")
        }
    }
    
}
