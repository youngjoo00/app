//
//  ApplyClothesListTableViewCell.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/23.
//

import UIKit

class ApplyClothesListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clothesLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
