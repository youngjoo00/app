//
//  MyReviewsTableViewCell.swift
//  Daeseda
//
//  Created by youngjoo on 2023/09/26.
//

import UIKit

class MyReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var myReviewNicknameLabel: UILabel!
    @IBOutlet var myReviewStarRating: [UIImageView]!
    @IBOutlet weak var myReviewTextLabel: UILabel!
    @IBOutlet weak var myReviewDateLabel: UILabel!
    @IBOutlet weak var myReviewImage: UIImageView!
    @IBOutlet weak var myReviewCategoryBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func myReviewEditBtn(_ sender: UIButton) {
    }
    
    @IBAction func myReviewDelBtn(_ sender: UIButton) {
    }
    
}
