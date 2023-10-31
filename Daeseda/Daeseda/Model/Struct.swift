
import Foundation

struct Email: Codable {
    let userEmail: String
}

struct CheckEmail: Codable {
    let userEmail: String
    let code: String
}

struct UserData: Codable {
    let userEmail: String
    let userName: String
    let userNickname: String
    let userPhone: String
    let userPassword: String
}

struct Order: Codable {
    var address: Address
    let clothesCount: [ClothesCount]
    let totalPrice: Int
    let washingMethod: String
    let pickupDate: String
    let deliveryDate: String
    let deliveryLocation: String
}

struct OrderList: Codable {
    let orderId: Int
    var user: UserInfoData
    let address: Address
    let clothesCount: [ClothesCount]
    let orderStatus: String
    let totalPrice: Int
    let washingMethod: String
    let pickupDate: String
    let deliveryDate: String
    let deliveryLocation: String
}

struct Address: Codable {
    var addressId: Int
    var addressName: String
    var addressRoad: String
    var addressDetail: String
    var addressZipcode: String
    var defaultAddress: Bool
}

struct ClothesCount: Codable {
    let clothes: Clothes
    let count: Int
}

struct Clothes: Codable {
    let clothesId: Int
    let clothesName: String
    let categoryId: Int
}

struct GetClothes: Codable {
    let clothesId: Int
    let clothesName: String
    let categoryId: Int
    let clothesPrice: String
}

struct Category : Codable {
    let categoryId : Int
    let categoryName : String
}

struct AuthorityDto: Codable {
    var authorityName: String
}

struct QnaListData: Codable {
    let boardId: Int
    let userId: Int
    let userNickname: String
    let boardCategory: String
    let boardTitle: String
    let boardContent: String
    let regDate: String
    let modDate: String
}

struct ComentData: Codable {
    let replyId: Int
    let userId: Int
    let userNickname: String
    let boardId: Int
    let replyContent: String
    let regDate: String
    let modDate: String
}

struct QnaWriteData: Codable {
    let boardCategory: String
    let boardTitle: String
    let boardContent: String
}

struct ComentPostData: Codable {
    let boardId: Int
    let replyContent: String
}

struct ComentEditData: Codable {
    let replyId : Int
    let boardId : Int
    let replyContent : String
}

struct QnaEditData: Codable {
    let boardId: Int
    let boardCategory: String
    let boardTitle: String
    let boardContent: String
}
struct ReviewData: Codable {
    let reviewId: Int
    let userId: Int
    let imageUrl: String
    let orderId: Int
    let rating: Float?
    let userNickname: String?
    let reviewTitle: String?
    let reviewContent: String?
    let regDate: String
}

struct ReviewCategoryData: Codable {
    let reviewCategoryId: Int
    let reviewId: Int
    let categories: Categories
}

struct Categories: Codable {
    let categoryId: Int
    let categoryName: String
}

struct UserInfoData: Codable {
    let userEmail: String
    let userName: String
    let userNickname: String
    let userPhone: String
    var authorityDtoSet: [AuthorityDto]?
    let addressDto: addressDto?
}

struct addressDto: Codable {
    let addressId: Int
    let addressName: String
    let addressRoad: String
    let addressDetail: String
    let addressZipcode: String
    let defaultAddress: Bool
}
struct AddressCreateData: Codable {
    var addressName: String
    var addressRoad: String
    var addressDetail: String
    var addressZipcode: String
}

struct ReviewWithCategory {
    let review: ReviewData
    let category: Categories
}

struct CardInfo: Codable {
    let cardName: String
    let cardNumber: String
    let order: OrderId
    let paidAmount: Int
    let payMethod: String
}

struct OrderId: Codable {
    let orderId: Int
}
