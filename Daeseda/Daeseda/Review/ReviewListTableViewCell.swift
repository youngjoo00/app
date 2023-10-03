import UIKit

class ReviewListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reviewListNicknameLabel: UILabel!
    @IBOutlet var reviewListStarRatingImageView: [UIImageView]!
    @IBOutlet weak var reviewListTextLabel: UILabel!
    @IBOutlet weak var reviewListDateLabel: UILabel!
    @IBOutlet weak var reviewListImageView: UIImageView!
    @IBOutlet weak var reviewListCategoryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

