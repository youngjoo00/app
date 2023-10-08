import UIKit

class EditOtherAdressTableViewCell: UITableViewCell {

    var indexPath: IndexPath?
    
    @IBOutlet weak var editOtherImageView: UIImageView!
    @IBOutlet weak var editOtherAdressLabel: UILabel!
    @IBOutlet weak var editOtherTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func editOtherEditBtn(_ sender: UIButton) {
    }
    @IBAction func editOtherDelBtn(_ sender: UIButton) {
    }
}
