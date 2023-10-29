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
        customerKey: "EPUx4U0_zvKaGMZkA7uF_"
    )
    
    public lazy var scrollView = UIScrollView()
    public lazy var stackView = UIStackView()
    private lazy var button = UIButton()
    
    public var scrollViewBottomAnchorConstraint: NSLayoutConstraint?
    
    
    var amount: Int = 0
    var orderId: String = ""
    var orderName: String = "대세다-대신 세탁해드립니다."
    
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
        
//        view.addSubview(button)
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
    }

}
extension PaymentViewController: TossPaymentsDelegate {

    public func didReceivedLoad(_ name: String) {
        print("결제위젯 렌더링 완료 ")
    }

    public func handleSuccessResult(_ success: TossPaymentsResult.Success) {
        print("결제 성공")
        print(success)
        
        self.dismiss(animated: true, completion: nil)
    }

    public func handleFailResult(_ fail: TossPaymentsResult.Fail) {
        print("결제 실패")
        print("errorCode: \(fail.errorCode)")
        print("errorMessage: \(fail.errorMessage)")
        print("orderId: \(fail.orderId)")

    }
}
