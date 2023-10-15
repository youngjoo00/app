//
//  OrderListViewController.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/15.
//

import UIKit

class OrderListViewController: UIViewController, UISheetPresentationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        orderListTableView.delegate = self
        orderListTableView.dataSource = self
        
    }
    
    let num = ["1","2"]
    let orderDate = ["2023-10-10", "2023-10-15"]
    let service = ["일반","특수"]
    let price = ["30000", "5000"]
    let state = ["배송대기", "배송중"]
    let finish = ["2023-10-13", "2023-10-19"]
    
    @IBOutlet weak var orderListTableView: UITableView!
    
    var segmentIndex: Int = 0
    
    // index 0: 주문내역, 1: 지난주문
    @IBAction func segmentControlValueChanged(_ sender: Any) {
        segmentIndex = (sender as AnyObject).selectedSegmentIndex
        orderListTableView.reloadData()
        
    }
    
}
extension OrderListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 여기서 셀의 높이를 동적으로 설정
        if segmentIndex == 0 {
            return 250.0 // 원하는 높이로 변경
        } else {
            return 250.0 // 원하는 높이로 변경
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
        cell.price.text = price[indexPath.row]
        cell.state.text = state[indexPath.row]
        cell.finishDate.text = finish[indexPath.row]
        cell.button.isHidden = true
        
        if segmentIndex == 0 {
            cell.finishDateLabel.isHidden = true
            cell.finishDate.isHidden = true
            
            if cell.state.text == "결제대기" {
                
                cell.button.isHidden = false
                cell.button.setTitle("결제 >", for: .normal)
                cell.button.removeTarget(self, action: #selector(deliveryInfo), for: .touchUpInside)
                cell.button.removeTarget(self, action: #selector(reviewWrite), for: .touchUpInside)
                cell.button.addTarget(self, action: #selector(payment), for: .touchUpInside)
                
            } else if cell.state.text == "배송중"{
                
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
    
    @objc func reviewWrite() {
        print("리뷰작성")
        guard  let reviewWriteVC = self.storyboard?.instantiateViewController(withIdentifier: "ReviewWrite") as? ReviewWriteViewController else { return }
        
        present(reviewWriteVC, animated: true, completion: nil)
    }
    
    
}
