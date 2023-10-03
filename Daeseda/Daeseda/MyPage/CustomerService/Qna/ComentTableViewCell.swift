//
//  ComentTableViewCell.swift
//  Daeseda
//
//  Created by youngjoo on 2023/09/26.
//

import UIKit

class ComentTableViewCell: UITableViewCell {

    @IBOutlet weak var comentNicknameLabel: UILabel!
    @IBOutlet weak var comentDateLabel: UILabel!
    @IBOutlet weak var comentTextLabel: UILabel!
    @IBOutlet weak var comentTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
