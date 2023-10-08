import UIKit

class ShowFaqViewController: UIViewController {
    
    @IBOutlet weak var faqText: UILabel!
    @IBOutlet weak var faqTitle: UILabel!
    
    var faqTitleString: String?
    var faqTextString: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        faqTitle.text = faqTitleString
        faqText.text = faqTextString
        
        print(faqTitle.text ?? "default value")
        print(faqText.text ?? "defalut value")
        
    }
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
