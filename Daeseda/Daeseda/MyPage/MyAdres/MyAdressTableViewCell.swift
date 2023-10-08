import UIKit

class MyAdressTableViewCell: UITableViewCell {

    @IBOutlet weak var adressCheckImageView: UIImageView!
    @IBOutlet weak var adressAdressLabel: UILabel!
    @IBOutlet weak var adressTitleLabel: UILabel!
    @IBOutlet weak var adressImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
