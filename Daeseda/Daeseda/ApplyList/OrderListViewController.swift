//
//  OrderListViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/15.
//

import UIKit
import Alamofire

class OrderListViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderListTableView.delegate = self
        orderListTableView.dataSource = self
        
        fetchCategoryInfo()
        print("1")
    }
    
    
    var num: [String] = []
    var orderDate: [String] = []
    var service: [String] = []
    var price: [String] = []
    var state: [String] = []
    var finish: [String] = []
    
    @IBOutlet weak var orderListTableView: UITableView!
    
    var segmentIndex: Int = 0
    
    var postOrderId : Int = 0
    
    func fetchCategoryInfo(){
        print("a")
        
        if let token = UserTokenManager.shared.getToken(){
            let headers: HTTPHeaders = ["Authorization": "Bearer " + token]
            
            AF.request("http://localhost:8888/orders/list", headers: headers).responseDecodable(of: [OrderList].self) { response in
                switch response.result {
                case .success(let orderList):
                    self.num.removeAll()
                    self.orderDate.removeAll()
                    self.service.removeAll()
                    self.price.removeAll()
                    self.state.removeAll()
                    self.finish.removeAll()
                    
                    for order in orderList {
                        let id = order.orderId
                        let pickup = order.pickupDate
                        let service = order.washingMethod
                        let price = order.totalPrice
                        let state = order.orderStatus
                        let finish = order.deliveryDate
                        
                        
                        self.num.append(String(id))
                        self.orderDate.append(pickup)
                        self.service.append(service)
                        self.price.append(String(price))
                        self.state.append(state)
                        self.finish.append(finish)
                        
                        if let authorityDtoSet = order.user.authorityDtoSet {
                            print(authorityDtoSet)
                        }
                        
                        print(order)
                    }
                    self.orderListTableView.reloadData()
                    
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    // index 0: 주문내역, 1: 지난주문
    @IBAction func segmentControlValueChanged(_ sender: Any) {
        segmentIndex = (sender as AnyObject).selectedSegmentIndex
        self.orderListTableView.reloadData()
    }
    
}
extension OrderListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 여기서 셀의 높이를 동적으로 설정
        if segmentIndex == 0 {
            return 180 // 원하는 높이로 변경
        } else {
            return 250 // 원하는 높이로 변경
        }
    }
    
}

extension OrderListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderListCell", for: indexPath) as! OrderListTableViewCell
        
        cell.orderNum.text = num[indexPath.row]
        cell.orderDate.text = orderDate[indexPath.row]
        cell.serviceType.text = service[indexPath.row]
        cell.price.text = "\(price[indexPath.row]) 원"
        cell.state.text = state[indexPath.row]
        cell.finishDate.text = finish[indexPath.row]
        cell.button.isHidden = true
        
        print(cell.orderNum.text)
        
        if segmentIndex == 0 {
            cell.finishDateLabel.isHidden = true
            cell.finishDate.isHidden = true
            
            if cell.state.text == "Cash" {
                
                cell.button.isHidden = false
                cell.button.setTitle("결제 >", for: .normal)
                cell.button.removeTarget(self, action: #selector(deliveryInfo), for: .touchUpInside)
                cell.button.removeTarget(self, action: #selector(reviewWrite), for: .touchUpInside)
                cell.button.addTarget(self, action: #selector(payment), for: .touchUpInside)
                
            } else if cell.state.text == "Complete"{
                
                cell.button.isHidden = false
                cell.button.setTitle("배송정보 >", for: .normal)
                cell.button.removeTarget(self, action: #selector(payment), for: .touchUpInside)
                cell.button.removeTarget(self, action: #selector(reviewWrite), for: .touchUpInside)
                cell.button.addTarget(self, action: #selector(deliveryInfo), for: .touchUpInside)
            }
        } else {
            
            cell.finishDateLabel.isHidden = false
            cell.finishDate.isHidden = false
            cell.button.isHidden = false
            cell.button.setTitle("리뷰작성 >", for: .normal)
            cell.button.removeTarget(self, action: #selector(payment), for: .touchUpInside)
            cell.button.removeTarget(self, action: #selector(deliveryInfo), for: .touchUpInside)
            cell.button.addTarget(self, action: #selector(reviewWrite), for: .touchUpInside)
            
        }
        
        return cell
        
    }
    
    @objc func payment() {
        guard  let paymentVC = self.storyboard?.instantiateViewController(withIdentifier: "Payment") as? PaymentViewController else { return }
        
        present(paymentVC, animated: true, completion: nil)
        
    }
    
    @objc func deliveryInfo() {
        guard  let deliveryInfoVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliveryInfo") as? DeliveryInfoViewController else { return }
        
        deliveryInfoVC.modalPresentationStyle = .pageSheet
        
        if let sheet = deliveryInfoVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.delegate = self
            sheet.prefersGrabberVisible = true
        }
        
        present(deliveryInfoVC, animated: true, completion: nil)
        
    }
    
    @objc func reviewWrite(_ sender: UIButton) {
        // 버튼을 포함하는 셀의 indexPath를 가져옵니다.
        if let indexPath = self.orderListTableView.indexPath(for: sender.superview?.superview as! UITableViewCell) {
            
            let orderNumText = num[indexPath.row]
            
            if let orderNum = Int(orderNumText) {
                guard let reviewWriteVC = self.storyboard?.instantiateViewController(withIdentifier: "ReviewWrite") as? ReviewWriteViewController else { return }
                reviewWriteVC.orderId = orderNum
                print(orderNum)
                
                present(reviewWriteVC, animated: true, completion: nil)
            }
        }
    }
}
