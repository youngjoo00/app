import Foundation

struct ReviewData: Codable {
    let reviewId: Int
    let userId: Int
    let imageUrl: String
    let orderId: Int
    let rating: Float?
    let reviewTitle: String?
    let reviewContent: String?
    let regDate: String
    let modDate: String
}
