//
//  PirceListTableViewCell.swift
//  Daeseda
//
//  Created by 축신효상 on 2023/10/22.
//

import UIKit

class PirceListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pirceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
