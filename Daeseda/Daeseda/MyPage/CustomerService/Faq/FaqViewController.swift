import UIKit

struct FAQItem {
    let title: String
    let text: String
    let category: String
}

class FaqViewController: UIViewController {
    
    var faqItems = [FAQItem]()
    var currentCategory: String?
    
    let dummyData: [FAQItem] = [
        FAQItem(title: "설 연휴 배송 안내1", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리1"),
        FAQItem(title: "설 연휴 배송 안내2", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리2"),
        FAQItem(title: "설 연휴 배송 안내3", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리3"),
        FAQItem(title: "설 연휴 배송 안내4", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리4"),
        FAQItem(title: "설 연휴 배송 안내5", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리5"),
        FAQItem(title: "설 연휴 배송 안내6", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리6"),
        FAQItem(title: "추석 연휴 배송 안내1", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리1"),
        FAQItem(title: "추석 연휴 배송 안내2", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리2"),
        FAQItem(title: "추석 연휴 배송 안내3", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리3"),
        FAQItem(title: "추석 연휴 배송 안내4", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리4"),
        FAQItem(title: "추석 연휴 배송 안내5", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리5"),
        FAQItem(title: "추석 연휴 배송 안내6", text: "대세다를 이용해 주셔서 감사합니다. 대세다는 세탁 서비스를 중심으로 여러분이 더욱 쉽고 편리하게 의생활을 누릴 수 있도록 서비스를 제공하여 편리한 삶을 지향하기 위해 탄생한 서비스입니다.", category: "카테고리6")
    ]
    
    @IBOutlet var faqCategoryBtns: [UIButton]!
    @IBOutlet weak var faqSearchBar: UISearchBar!
    @IBOutlet weak var faqTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.faqSearchBar.searchBarStyle = .minimal
        // Initially load data for the first category
        loadFAQData(category: "카테고리1")
        
        faqTableView.delegate = self
        faqTableView.dataSource = self
        faqSearchBar.delegate = self
    }
    
    func loadFAQData(category: String) {
        // filter 를 이용해 다른 카테고리 배열 제외
        faqItems = dummyData.filter { $0.category == category }
        currentCategory = category
        faqTableView.reloadData()
    }
    
    func filterFAQData(searchText: String) {
        faqItems = dummyData.filter { $0.category == currentCategory && $0.title.contains(searchText) }
        faqTableView.reloadData()
    }
}

extension FaqViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let currentCategory = currentCategory {
            if searchText.isEmpty {
                loadFAQData(category: currentCategory)
            } else {
                filterFAQData(searchText: searchText)
                print(searchText)
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
extension FaqViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showFaqVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowFaq") as! ShowFaqViewController
        
        let selectedItem = faqItems[indexPath.row]
        showFaqVC.faqTitleString = selectedItem.title
        showFaqVC.faqTextString = selectedItem.text
        
        self.present(showFaqVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

extension FaqViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return faqItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let faqCell = tableView.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath) as! FaqTableViewCell
        
        let selectedItem = faqItems[indexPath.row]
        faqCell.faqTitleLabel.text = selectedItem.title
        
        return faqCell
    }
    
}

// Handle category button tap
extension FaqViewController {
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        if let category = sender.titleLabel?.text {
            loadFAQData(category: category)
        }
    }
}
