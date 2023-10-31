import UIKit
import Alamofire

struct FAQItem : Codable {
    var noticeId: Int
    var noticeCategory: String
    var noticeTitle: String
    var noticeContent: String
    var regDate: String
    var modDate: String
}

class FaqViewController: UIViewController {
    
    var faqItems = [FAQItem]()
    var filteredFAQItems = [FAQItem]()  // 필터링된 결과를 저장할 배열
    var currentCategory: String?
    
    let endPoint = "/notice/list"
    
    @IBOutlet var faqCategoryBtns: [UIButton]!
    @IBOutlet weak var faqSearchBar: UISearchBar!
    @IBOutlet weak var faqTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.faqSearchBar.searchBarStyle = .minimal
        
        // Initially load data for the first category (전체)
        loadFAQData(category: "전체")
        
        faqTableView.delegate = self
        faqTableView.dataSource = self
        faqSearchBar.delegate = self
        
        // 화면이 로드될 때 FAQ 데이터를 서버에서 가져옴
        getFAQData()
        
        // 모든 데이터를 화면에 표시
        filteredFAQItems = faqItems
        faqTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
            
        self.navigationItem.title = .none
    }
    @IBAction func categoryButtonTapped(_ sender: UIButton) {
        if let category = sender.titleLabel?.text {
            loadFAQData(category: category)
        }
    }
    
    func getFAQData() {
        let fullURL = baseURL.baseURLString + self.endPoint
        
        AF.request(fullURL).responseDecodable(of: [FAQItem].self) { response in
            switch response.result {
            case .success(let fetchedFAQ):
                self.faqItems = fetchedFAQ
                
                // 데이터를 noticeId를 기준으로 내림차순으로 정렬
                self.faqItems.sort { $0.noticeId > $1.noticeId }
                
                // 모든 데이터를 화면에 표시
                self.filteredFAQItems = self.faqItems
                self.faqTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadFAQData(category: String) {
        if category == "전체" {
            currentCategory = nil
            // 전체 카테고리를 선택한 경우, 로컬 데이터에서 필터링하지 않고 전체 데이터를 사용
            filteredFAQItems = faqItems
        } else {
            currentCategory = category
            // 선택한 카테고리에 해당하는 FAQ 데이터만 필터링하여 배열에 저장
            filteredFAQItems = faqItems.filter { $0.noticeCategory == category }
        }
        faqTableView.reloadData()
    }
    
    
    
    func filterFAQData(searchText: String) {
        if searchText.isEmpty {
            if let currentCategory = currentCategory {
                // 검색어가 비어있는 경우, 현재 카테고리의 필터된 데이터를 사용
                if currentCategory == "전체" {
                    filteredFAQItems = faqItems
                } else {
                    filteredFAQItems = faqItems.filter { $0.noticeCategory == currentCategory }
                }
            }
        } else {
            if let currentCategory = currentCategory, currentCategory != "전체" {
                // 현재 카테고리에서 검색어를 포함하는 데이터만 필터링하여 배열에 저장
                filteredFAQItems = faqItems.filter { $0.noticeCategory == currentCategory && ($0.noticeTitle.contains(searchText) || $0.noticeContent.contains(searchText)) }
            } else {
                // 전체 카테고리에서 검색어를 포함하는 데이터만 필터링하여 배열에 저장
                filteredFAQItems = faqItems.filter { $0.noticeTitle.contains(searchText) || $0.noticeContent.contains(searchText) }
            }
        }
        faqTableView.reloadData()
    }


}

extension FaqViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterFAQData(searchText: searchText)
        print(searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension FaqViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let showFaqVC = self.storyboard?.instantiateViewController(withIdentifier: "ShowFaq") as! ShowFaqViewController
        
        let selectedItem = filteredFAQItems[indexPath.row]
        showFaqVC.faqTitleString = selectedItem.noticeTitle
        showFaqVC.faqTextString = selectedItem.noticeContent
        
        self.present(showFaqVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

extension FaqViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFAQItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let faqCell = tableView.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath) as! FaqTableViewCell
        
        let selectedItem = filteredFAQItems[indexPath.row]
        faqCell.faqTitleLabel.text = selectedItem.noticeTitle
        
        return faqCell
    }
}
