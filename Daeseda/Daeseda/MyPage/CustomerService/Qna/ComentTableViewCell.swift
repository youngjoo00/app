import UIKit

class ComentTableViewCell: UITableViewCell {

    @IBOutlet weak var comentNicknameLabel: UILabel!
    @IBOutlet weak var comentDateLabel: UILabel!
    @IBOutlet weak var comentTextLabel: UILabel!
    @IBOutlet weak var comentTimeLabel: UILabel!
    @IBOutlet weak var comentDelBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        comentDelBtn.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
