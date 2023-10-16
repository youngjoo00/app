//
//  OrderListTableViewCell.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/16.
//

import UIKit

class OrderListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var finishDateLabel: UILabel!
    
    
    @IBOutlet weak var orderNum: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var serviceType: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var finishDate: UILabel!
    
    
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
