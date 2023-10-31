import UIKit
import Photos
import Alamofire

class ReviewWriteViewController: UIViewController {
    
    var reviewViewController: ReviewViewController?
    
    let allCategorys = [
        "전체",
        "생활빨래",
        "가방",
        "신발",
        "코트",
        "대형이불",
        "등등등1",
        "등등등2",
        "등등등3",
    ]
    
    @IBOutlet weak var reviewUploadImage: UIImageView!
    @IBOutlet var reviewStarRatingBtns: [UIButton]!
    @IBOutlet weak var reviewTextView: UITextView!
    
    var rating: Float = 1.0 // 최소 별점을 1로 설정
    var orderId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let reviewWriteBarBtnItem = UIBarButtonItem(
//            title: "등록",
//            style: .plain,
//            target: self,
//            action: #selector(reviewPostBtn)
//        )
//        navigationItem.rightBarButtonItem = reviewWriteBarBtnItem
        
        // 터치 제스처 추가: 키보드 외의 영역 터치 시 키보드 내리기
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        
        self.reviewTextView.layer.borderWidth = 1.0
        self.reviewTextView.layer.borderColor = UIColor.black.cgColor
        
        for (index, button) in reviewStarRatingBtns.enumerated() {
            button.tag = index
            button.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
        }
        
        updateStarUI()
        
        self.title = "리뷰 작성"
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // 리뷰 등록
//    @objc func reviewPostBtn(_ sender: UIBarButtonItem) {
//        let url = baseURL.baseURLString + "/review/register"
//
//        // 이미지 파일 (이미지 파일을 준비하고, 이미지 데이터로 변환해야 함)
//        guard let image = reviewUploadImage.image, let imageData = image.jpegData(compressionQuality: 1) else {
//            print("Please select an image or failed to convert image to data.")
//            return
//        }
//
//        // 리뷰 데이터 생성
//        guard let reviewTitle = title else {
//            print("Please enter a review title.")
//            return
//        }
//        guard let reviewContent = reviewTextView.text else {
//            print("Please enter review content.")
//            return
//        }
//
//        guard let orderId = self.orderId else {
//            print("orderId 필요")
//            return
//        }
//        // 토큰 가져오기
//        if let token = UserTokenManager.shared.getToken() {
//            let headers: HTTPHeaders = [
//                "Authorization": "Bearer " + token,
//                "Content-Type": "multipart/form-data"
//            ]
//
//            AF.upload(
//                multipartFormData: { multipartFormData in
//                    // 이미지를 추가하는 부분은 그대로 둡니다.
//                    multipartFormData.append(imageData, withName: "image", fileName: "reviewImage.jpg", mimeType: "image/jpeg")
//
//                    // 리뷰 데이터를 `multipart/form-data` 형식으로 보냅니다.
//                    if let reviewTitleData = reviewTitle.data(using: .utf8) {
//                        multipartFormData.append(reviewTitleData, withName: "reviewTitle")
//                    }
//                    if let reviewContentData = reviewContent.data(using: .utf8) {
//                        multipartFormData.append(reviewContentData, withName: "reviewContent")
//                    }
//                    if let orderIdData = "\(orderId)".data(using: .utf8) {
//                        multipartFormData.append(orderIdData, withName: "orderId")
//                    }
//                    if let ratingData = "\(self.rating)".data(using: .utf8) {
//                        multipartFormData.append(ratingData, withName: "rating")
//                    }
//                },
//                to: url,
//                method: .post,
//                headers: headers
//            )
//            .response { response in
//                switch response.result {
//                case .success:
//                    print("ReviewWrite Success")
//                    self.navigationController?.popViewController(animated: true)
//                case .failure(let error):
//                    print("Error: \(error.localizedDescription)")
//                }
//            }
//            .validate(statusCode: 200..<300)
//        } else {
//            print("Token not available.")
//        }
//
//
//    }
    
    @objc func starButtonTapped(_ sender: UIButton) {
        rating = Float(sender.tag) + 1.0
        updateStarUI()
    }
    
    func updateStarUI() {
        for (index, button) in reviewStarRatingBtns.enumerated() {
            if Float(index) < rating {
                button.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                button.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    
    @IBAction func reviewUploadImageBtn(_ sender: UIButton) {
        // 사진 라이브러리 권한 확인
        authPhotoLibrary(self) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func reviewWriteCompleteBtn(_ sender: UIButton) {
        let url = baseURL.baseURLString + "/review/register"
        
        // 이미지 파일 (이미지 파일을 준비하고, 이미지 데이터로 변환해야 함)
        guard let image = reviewUploadImage.image, let imageData = image.jpegData(compressionQuality: 1) else {
            print("Please select an image or failed to convert image to data.")
            return
        }
        
        // 리뷰 데이터 생성
        guard let reviewTitle = title else {
            print("Please enter a review title.")
            return
        }
        guard let reviewContent = reviewTextView.text else {
            print("Please enter review content.")
            return
        }
        
        guard let orderId = self.orderId else {
            print("orderId 필요")
            return
        }
        // 토큰 가져오기
        if let token = UserTokenManager.shared.getToken() {
            let headers: HTTPHeaders = [
                "Authorization": "Bearer " + token,
                "Content-Type": "multipart/form-data"
            ]
            
            AF.upload(
                multipartFormData: { multipartFormData in
                    // 이미지를 추가하는 부분은 그대로 둡니다.
                    multipartFormData.append(imageData, withName: "image", fileName: "reviewImage.jpg", mimeType: "image/jpeg")
                    
                    // 리뷰 데이터를 `multipart/form-data` 형식으로 보냅니다.
                    if let reviewTitleData = reviewTitle.data(using: .utf8) {
                        multipartFormData.append(reviewTitleData, withName: "reviewTitle")
                    }
                    if let reviewContentData = reviewContent.data(using: .utf8) {
                        multipartFormData.append(reviewContentData, withName: "reviewContent")
                    }
                    if let orderIdData = "\(orderId)".data(using: .utf8) {
                        multipartFormData.append(orderIdData, withName: "orderId")
                    }
                    if let ratingData = "\(self.rating)".data(using: .utf8) {
                        multipartFormData.append(ratingData, withName: "rating")
                    }
                },
                to: url,
                method: .post,
                headers: headers
            )
            .response { response in
                switch response.result {
                case .success:
                    print("ReviewWrite Success")
                    self.dismiss(animated: true, completion: nil)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
            .validate(statusCode: 200..<300)
        } else {
            print("Token not available.")
        }
    }
    
    // 다른 영역 터치 시 키보드 내리기
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        reviewTextView.resignFirstResponder() // 현재 First Responder 해제
    }
}

extension ReviewWriteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            reviewUploadImage.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
